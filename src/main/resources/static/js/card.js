document.addEventListener('DOMContentLoaded', async () => {
    // Load the publishable key from the server. The publishable key
    // is set in your .env file.
    document.querySelector("#amount").textContent = amount;
    document.querySelector("#hiddenName").textContent = name;
    document.querySelector("#hiddenEmail").textContent = email;

    const {publishableKey} = await fetch('/api/v1/payments/config').then((r) => r.json());
    if (!publishableKey) {
        addMessage('No publishable key returned from the server. Please check `.env` and try again');
        alert('Please set your Stripe publishable API key in the .env file');
    }

    const stripe = Stripe(publishableKey, {
        apiVersion: '2020-08-27',
    });

    //Mount card into Stripe
    const elements = stripe.elements();
    const card = elements.create('card');
    card.mount('#card-element');

    // When the form is submitted...
    const form = document.getElementById('payment-form');
    let submitted = false;
    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        const nameInput = document.querySelector('#name');
        const emailInput = document.getElementById('email').value;

        // Disable double submission of the form
        if(submitted) { return; }
        submitted = true;
        form.querySelector('button').disabled = true;

        // Make a call to the server to create a new
        // payment intent and store its client_secret.
        const {error: backendError, clientSecret} = await fetch(
            '/api/v1/payments/create-payment-intent',
            {
                method: 'POST',
                headers: {
                'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    currency: 'usd',
                    paymentMethodType: 'card',
                    amount: amount * 100,
                    email: emailInput,

                }),
            }
        ).then((r) => r.json());

        if (backendError) {
            addMessage(backendError.message);

            // reenable the form.
            submitted = false;
            form.querySelector('button').disabled = false;
            return;
        }

        addMessage(`Client secret returned.`);

        // Confirm the card payment given the clientSecret
        // from the payment intent that was just created on the server.
        const {error: stripeError, paymentIntent} = await stripe.confirmCardPayment(
            clientSecret,
            {
                payment_method: {
                    card: card,
                    billing_details: {
                        name: nameInput.value,
                        email: emailInput.value,
                    },
                },
            }
        );

        if (stripeError) {
            addMessage(stripeError.message);

            // reenable the form.
            submitted = false;
            form.querySelector('button').disabled = false;
            return;
        }

        addMessage(`Payment ${paymentIntent.status}: ${paymentIntent.id}`);
        // fetch another endpoint here that post message to send email
        document.location = '/success?payment_intent_client_secret=' + paymentIntent.client_secret;
    });
});

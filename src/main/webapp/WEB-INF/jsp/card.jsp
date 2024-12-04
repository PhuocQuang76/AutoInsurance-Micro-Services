<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Card</title>
    <link rel="stylesheet" href="css/base.css" />
    <script src="https://js.stripe.com/v3/"></script>
    <script src="js/utils.js" defer></script>
    <script src="js/card.js" defer></script>
    <script src="http://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<script type="text/javascript">
    var url_string = (window.location.href).toLowerCase();
    var url = new URL(url_string);
    var name = url.searchParams.get("username");
    var email = url.searchParams.get("email");
    var amount = url.searchParams.get("amount");

</script>
<body>
    <div>
        <a href="http://localhost:9696/yourQuoteForm">Back to the Quote</a>
        <h1 style="font-family:Marker Felt, fantasy;text-align: center;" >Card</h1>

        <section>
            <div><code>4242424242424242</code> (Visa)</div>
            <div><code>5555555555554444</code> (Mastercard)</div>

        </section>

        <p style="font-weight: 200";>Use any future expiration, any 3 digit CVC, and any postal code.</p>

        <form id="payment-form">
            <div style="font-family:Marker Felt, fantasy; font-size: 24px; text-align: center;" ><span >Amount: </span><span id="amount"></span></div>
            <p style="display:none" id="hiddenName"></p>
            <p style="display:none" id="hiddenEmail"></p>
            <label for="name">User Information</label>
            <input id="name" required/>
            <input id="email" required />

            <label for="card-element">Card Information</label>

            <!-- Elements will create input elements here -->
            <div id="card-element"></div>

            <!-- We ll put the error messages in this element -->
            <div id="card-errors" role="alert"></div>

            <button id="submit">Pay</button>
        </form>

        <div id="messages" role="alert" style="display: none;"></div>


    </div>
</body>
</html>

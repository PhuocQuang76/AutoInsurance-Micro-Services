package com.synergisticit.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
//@ToString
@Getter
@Setter
@Entity
@Table(name="user")
public class User {
	
	 @Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	 @NotNull
     private Long userId;
     
	 @NotEmpty
	 @Column(name="name")
     String username;
     
	 @NotEmpty
     String password;
     
	 @Email
	 @NotEmpty
     String email;
//
//@JsonBackReference
//@JsonManagedReference
	 @ManyToMany(fetch=FetchType.EAGER)
     @JoinTable(name="user_role",
        joinColumns = { @JoinColumn(name="user_id")},
        inverseJoinColumns = {@JoinColumn(name="role_id")})
     List<Role> roles = new ArrayList<>();
        
}

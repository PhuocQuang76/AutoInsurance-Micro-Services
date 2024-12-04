package com.synergisticit.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
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
//@ToString //to avoid StackOverflowError
@Getter
@Setter
@Entity
@Table(name="role")
public class Role {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@NotNull
	private Long roleId;
	
	@NotEmpty
	private String name;
//	@JsonBackReference
//	@JsonManagedReference
	@ManyToMany(mappedBy="roles")
	private List<User> users = new ArrayList<>();
	

}

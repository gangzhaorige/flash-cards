package com.flashcards.server.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.flashcards.server.entity.ERole;
import com.flashcards.server.entity.Role;
import com.flashcards.server.entity.User;
import com.flashcards.server.payload.requests.LoginRequest;
import com.flashcards.server.payload.requests.SignupRequest;
import com.flashcards.server.payload.responses.MessageResponse;
import com.flashcards.server.payload.responses.UserInfoResponse;
import com.flashcards.server.repositories.RoleRepository;
import com.flashcards.server.repositories.UserRepository;
import com.flashcards.server.security.jwt.JwtUtils;
import com.flashcards.server.security.services.UserDetailsImpl;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;

@RestController
@RequestMapping("/auth")
public class AuthController {
    
    /* 
        regex for password_pattern
        atleast 8 character long with 1 letter or number
    */
    final static String PASSWORD_PATTERN = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

    // regex for a valid email pattern.
    final static String EMAIL_PATTERN = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    
    /* 
        regest for username pattern
        starts with a character, Alphanumerical, Uppercase, Lowercase character and Underscore are allowed.
    */
    final static String USERNAME_PATTERN = "^[A-Za-z]\\w{5,29}$";

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    PasswordEncoder encoder;

    @Autowired
    JwtUtils jwtUtils;

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        ResponseCookie jwtCookie = jwtUtils.generateJwtCookie(userDetails);
        List<String> roles = userDetails.getAuthorities().stream()
                .map(item -> item.getAuthority())
                .collect(Collectors.toList());

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, jwtCookie.toString()).body(
                new UserInfoResponse(
                        userDetails.getId(),
                        userDetails.getEmail(),
                        userDetails.getUsername(),
                        roles));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest) {
        Map<String, Object> json = new HashMap<>();
        List<String> errors = new ArrayList<>();
        String email = signUpRequest.getEmail();
        String username = signUpRequest.getUsername();
        String password = signUpRequest.getPassword();
        if (!email.matches(EMAIL_PATTERN)) {
            errors.add("Please check your email and try again.");
        }
        if (userRepository.existsByEmail(email)) {
            errors.add("Email is already in use! Please login or use a different email!");
        }
        if (userRepository.existsByUsername(username)) {
            errors.add("Username is already in use!");
        }
        if (!username.matches(USERNAME_PATTERN)) {
            errors.add("Username must start with character. Allowed alphanumerical characters and underscore.");
        }
        if (!password.matches(PASSWORD_PATTERN)) {
            errors.add("Password is too weak! At least 8 characters with 1 letter and 1 number.");
        }
        if(!errors.isEmpty()) {
            json.put("errors", errors);
            return ResponseEntity.badRequest().body(json);
        }
        User user = new User(email, username, encoder.encode(password));

        Set<String> strRoles = null;

        Set<Role> roles = new HashSet<>();

        if (strRoles == null) {
            Role userRole = roleRepository.findByName(ERole.ROLE_USER)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(userRole);
        }
        user.setRoles(roles);
        userRepository.save(user);
        return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
    }

    @PostMapping("/signout")
    public ResponseEntity<?> logoutUser() {
        ResponseCookie cookie = jwtUtils.getCleanJwtCookie();
        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString()).body(
                new MessageResponse(
                        "You've been signed out!"));
    }
}

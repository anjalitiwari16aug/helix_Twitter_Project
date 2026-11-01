<!DOCTYPE html>
<html lang="en">
<link rel = "shortcut icon" type="image/png" href="/static/images/favicon.ico"/>
<head>
<script
  src="https://code.jquery.com/jquery-4.0.0.min.js"
  integrity="sha256-OaVG6prZf4v69dPg6PhVattBXkcOWQB62pdZ3ORyrao="
  crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
    <link rel="stylesheet" href="style.css">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    .container {
        width: 100%;
        min-height: 100vh;
        width: 100%;
        background: #1DA1F2 ;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .registration {
        width: 500px;
        background-color: white;
        padding: 20px;
        border-radius: 7px;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
        margin: 20px;
    }

    .registration h2 {
        font-weight: 500;
        text-align: center;
        margin-bottom: 1.5rem;
    }

    .form input {
        height: 60px;
        width: 100%;
        padding: 0 15px;
        font-size: 17px;
        margin-bottom: 1.3rem;
        border: 1px solid #ddd;
        border-radius: 6px;
        outline: none;
    }

    .form input:focus {
        box-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
    }

    .form a {
        font-size: 16px;
        color: #1DA1F2;
        text-decoration: none;
        cursor: pointer;
    }

    .form a:hover {
        text-decoration: underline;
    }

    .form input.button {
        color: #fff;
        background: #1DA1F2;
        font-size: 1.2rem;
        font-weight: 500;
        letter-spacing: 1px;
        margin-top: 1.7rem;
        cursor: pointer;
        transition: 0.4s;
    }

    .form input.button:hover {
        background: #1DA178;
    }

    .signup {
        font-size: 17px;
        text-align: center;
    }

    .signup label {
        color: #009579;
        cursor: pointer;
    }

    .signup label:hover {
        text-decoration: underline;
    }

    </style>
</head>

<body>
    <div class="container">
        <div class="registration form">
            <h2>Login your account</h2>
            <p>Welcome to the social network of coder by Mission Helix</p>
            <form action="#">

                <label for = "email">Email</label><br>
                <input id = "signup-email" type="text" name="email" placeholder="Enter your email"><br>
                <label for = "password">Password</label><br>
                <input id="signup-password" type="password" name="password" placeholder="Create a password">

                <p style="color:red; display:none" id="signup-error"></p>

                <button type="button" id="btn-signup" >Login</button>
            </form>
                <span class="signup">Already have an account?
                    <a>Login</a>
                </span>
        </div>
    </div>

    <script>

         function validateSignupForm(){

         var email=$("#signup-email").val();
         var password=$("#signup-password").val();

         var error = "";


         if(!email){
         error+="Email is empty.";
         }
         if(!password){
         error+="Password is empty.";
         }

         if(password.length<=3){
         error+="Password length must be greater than 3 characters";
         }

         $("#signup-error").html(error);
         $("#signup-error").show();

         if(error.length>0){
         return false;
         }
         return true;

         }

         $("#btn-signup").click(function(){
            var isFormValid = validateSignupForm();
            if(isFormValid){
             $("#signup-error").hide();
             var email = $("#signup-email").val();
             var password =  $("#signup-password").val();

             var user = {
                          "email" : email,
                          "password": password
                          };

            $.ajax({
                type: "POST",
                url: "/login/welcome",
                data: JSON.stringify(user),
                success: function(response) {
                 if(!!response){
                     if(response.is_logined===true){
                     location.href = "/user/welcome";
                     }else{
                     $("#signup-password").val("");
                     $("#signup-error").html(response.message);
                     $("#signup-error").show();
                     }
                 }

                 },
                contentType: "application/json"
            });
            }else{
             $("#signup-error").show();
            }
         });
    </script>
</body>

</html>
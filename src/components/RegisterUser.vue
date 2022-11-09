<template>
    <div class="container">
        <div class="couleur">Connecter vous avec :</div>
        <div class="form">
            <div class="user-details">
                <div class="input-box">
                    <input type="text" name="user" placeholder="Votre nom d'utilisateur" v-model="user.username" autofocus required>
                </div>
                <div class="input-box">
                    <input type="email" name="mail" placeholder="Email" v-model="user.email" required>
                </div>
                <div class="input-box">
                <input class="password" type="password" id="motdepasse" name="mdp" placeholder="Mot de passe" v-model="user.password" required>
                </div>
                <div class="input-box">
                <input class="password" type="password" id="motdepasse" name="mdp" placeholder="Mot de passe de confirmation" v-model="user.password_confirmation" required>
                </div>
            </div>
            <p class="couleur">Vous possèdez déjà un compte? Cliquer <a href="/LoginUser">Ici</a></p>
            <div class="button">
                <input type="submit" name="submit" id="regbtn" value="S'enregistrer" v-on:click="register()">
            </div>
        </div>
    </div>
</template>
  
<script>
import axios from 'axios';


    export default {
    name: 'RegisterUser',
    data() {
    return {
      users: [],
      user: {
        id: '',
        username: '',
        email: '',
        password: '',
        password_confirmation: '',
        role: ''
      }
    }
  },
    methods: {
        setStorages(token) {
            var expires = new Date(Date.now()+ 86400*1000);
			var sessionObject = {
				expiresAt: expires,
				SessionData: {
					token: token
				}
			}
            sessionStorage.setItem('sessionObject', JSON.stringify(sessionObject));
        },
        register() {
            if (this.user.password == this.user.password_confirmation && this.user.password.length > 8) {
                const register_url = "http://localhost:4000/api/v1/sign_up";
                const register =
                {
                    "users": {
                        "username": this.user.username,
                        "email": this.user.email,
                        "password": this.user.password
                    }
                };
                axios
                    .post(register_url, register)
                    .then (response => (
                        console.log(response),
                        alert("Bienvenue " + this.user.username + ". Vous avez été enregistrer avec succès"),
                        this.user.username = "",
                        this.user.email = "",
                        this.user.password = "",
                        this.user.password_confirmation = "",
                        window.location.href = '/LoginUser'
                    ))
                    .catch(error => console.log(error))
            }else{
                this.password = ""
                this.password_confirmation = ""
                return alert("les mots de passe ne correspondent pas")
            }
        },
        checkSessionObject() {
			const sessionObject = JSON.parse(sessionStorage.getItem('sessionObject'));
			if (sessionObject != null){
				const currentDate = new Date();
				const expirationDate = sessionObject.expiresAt;
				if(Date.parse(currentDate) < Date.parse(expirationDate)) {
					//normal application behaviour => session is not expired
					this.token = sessionObject.SessionData.token;
				} else {
					//redirect users to login page 
					sessionStorage.removeItem('sessionObject');
					alert("Session Expired");
				}
			}
		}
    },
    mounted() {
        this.checkSessionObject();
    }
}

</script>

<style>
.container{
    margin-top: 10%;
    max-width: 100%;
    width: 100%;
    background: rgb(250, 250, 250);
    padding: 25px 30px;
    border-radius: 5px;
}

.container .title{
    font-size: 25px;
    font-weight: 500;
    position: relative;
}

.container .title::before{
    content: '';
    position: left;
    left: 0;
    bottom: 0;
    height: 3px;
    width: 30px;
    background: linear-gradient(135deg, #71b7e6, #9b59b6);
}

.container .form .user-details{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin: 20px 0 12px 0;
}

.form .user-details .input-box{
    margin-bottom: 15px;
    width: calc(100% / 2 - 20px);
}

.user-details .input-box .details{
    display: block;
    font-weight: 500;
    margin-bottom: 5px;
}

.user-details .input-box input{
    height: 45px;
    width: 90%;
    outline: none;
    border-radius: 5px;
    border: 1px solid #ccc;
    padding-right: 15px;
    font-size: 16px;
    border-bottom-width: 2px;
    transition: all 0.3s ease;
}

.user-details .input-box input:focus,
.user-details .input-box2 input:focus,
.user-details .input-box input:valid,
.user-details .input-box2 input:valid{
    border-color: #eb7371;

}

.form .button{
    height: 45px;
    margin: 45px 0;
}

.form .button input{
    height: 100%;
    width: 100%;
    outline: none;
    color: #fff;
    border: none;
    font-size: 18px;
    font-weight: 500;
    border-radius: 5px;
    letter-spacing: 1px;
    background-color: #eb7371;
    cursor: pointer;
}

.form .button input:hover{
    background: linear-gradient(135deg, #9b59b6, #71b7e6);
}


input[type="checkbox"].check + label::before {
    box-sizing: border-box;
    display: block;
    content: "";
    height: calc(1.5rem - 4px);
    width: calc(1.5rem - 4px);
    border-radius: 50%;
    background-color: #fff;
    transition: all 0.5s ;
  }

input[type="checkbox"].check:checked + label::before {
    margin-left: 1.5rem ;
  }

.couleur{
    color: black;
}

@media (max-width: 584px){
    .container{
        max-width: 100%;
    }
    .form .user-details .input-box{
        margin-bottom: 15px;
        width: 100%;
    }

    .form .genre .category{
        width: 100%;
    }
    .container .form .user-details{
        max-height: 300px;
        overflow-y: scroll;
    }
}
</style>
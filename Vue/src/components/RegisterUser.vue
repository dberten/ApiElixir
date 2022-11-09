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
            var expires = new Date(Date.now() + 86400 * 1000);
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
                const register_url = "http://localhost:4000/api/sign_up";
                const register =
                {
                    "user": {
                        "username": this.user.username,
                        "email": this.user.email,
                        "password": this.user.password,
                        "role": [0]
                    }
                };
                axios
                    .post(register_url, register)
                    .then(response => (
                        console.log(response),
                        alert("Bienvenue " + this.user.username + ". Vous avez été enregistrer avec succès"),
                        this.user.username = "",
                        this.user.email = "",
                        this.user.password = "",
                        this.user.password_confirmation = "",
                        window.location.href = '/LoginUser'
                    ))
                    .catch(error => console.log(error))
            } else {
                this.password = ""
                this.password_confirmation = ""
                return alert("les mots de passe ne correspondent pas")
            }
        },
        checkSessionObject() {
            const sessionObject = JSON.parse(sessionStorage.getItem('sessionObject'));
            if (sessionObject != null) {
                const currentDate = new Date();
                const expirationDate = sessionObject.expiresAt;
                if (Date.parse(currentDate) < Date.parse(expirationDate)) {
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

<template>
    <div class="container">
        <div class="couleur">Connecter vous avec :</div>
        <div class="form">
            <div class="user-details">
                <div class="input-box">
                    <input type="text" name="user" placeholder="Votre nom d'utilisateur" v-model="user.username"
                        autofocus required>
                </div>
                <div class="input-box">
                    <input type="email" name="mail" placeholder="Email" v-model="user.email" required>
                </div>
                <div class="input-box">
                    <input class="password" type="password" id="motdepasse" name="mdp" placeholder="Mot de passe"
                        v-model="user.password" required>
                </div>
                <div class="input-box">
                    <input class="password" type="password" id="motdepasse" name="mdp"
                        placeholder="Mot de passe de confirmation" v-model="user.password_confirmation" required>
                </div>
            </div>
            <p class="couleur">Vous possèdez déjà un compte? Cliquer <a href="/LoginUser">Ici</a></p>
            <div class="button">
                <input type="submit" name="submit" id="regbtn" value="S'enregistrer" v-on:click="register()">
            </div>
        </div>
    </div>
</template>
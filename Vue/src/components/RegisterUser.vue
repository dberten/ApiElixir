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
    <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card bg-dark text-white" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-center">

                                <div class="mb-md-5 mt-md-4 pb-5">

                                    <h2 class="fw-bold mb-2 text-uppercase">Sign In</h2>
                                    <p class="text-white-50 mb-5">Créer un compte maintenant!</p>

                                    <div class=" form-floating mb-4">
                                        <input type="text" id="typeUserX" class="form-control bg-white"
                                            placeholder=" " v-model="user.username" required />
                                        <label class="text-dark" for="typeUserX">Nom d'Utilisateur</label>
                                    </div>

                                    <div class=" form-floating mb-4">
                                        <input type="email" id="typeEmailX" class="form-control bg-white"
                                            placeholder=" " v-model="user.email" required />
                                        <label class="text-dark" for="typeEmailX">Email</label>
                                    </div>

                                    <div class="form-outline form-floating form-white mb-4">
                                        <input type="password" id="typePasswordX" class="form-control bg-white"
                                            placeholder=" " v-model="user.password" required />
                                        <label class="form-label text-dark" for="typePasswordX">Mot de passe</label>
                                    </div>

                                    <div class="form-outline form-floating form-white mb-4">
                                        <input type="password" id="typePasswordX" class="form-control bg-white"
                                            placeholder=" " v-model="user.password_confirmation" required />
                                        <label class="form-label text-dark" for="typePasswordX">Confirmer votre Mot de passe</label>
                                    </div>

                                    <button class="btn btn-outline-light btn-lg px-5" type="submit"
                                        v-on:click="register()">S'inscrire</button>

                                </div>

                                <div>
                                    <p class="mb-0">Vous possèdez déjà un compte?
                                        <router-link to="/LoginUser" class="text-success fw-bold">
                                            Cliquer Ici
                                        </router-link>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

</template>
<script>
import axios from 'axios';

export default {
    name: 'LoginUser',
    data() {
        return {
            users: [],
            user: {
                email: '',
                password: ''
            }
        }
    },
    methods: {
        setStorages(token) {
            var expires = new Date(Date.now() + 86400 * 1000);
            var sessionObject = {
                expiresAt: expires,
                SessionData: {
                    token: token,
                    navbar: true
                }
            }
            sessionStorage.setItem('sessionObject', JSON.stringify(sessionObject));
        },
        login() {
            if (this.user.password.length > 8) {
                const login_url = "http://localhost:4000/api/sign_in";
                const login =
                {
                    "email": this.user.email,
                    "password": this.user.password
                };
                axios.post(login_url, login)
                    .then(response => (
                        this.setStorages(response.data.jwt),
                        document.location.reload()
                    ))
                    .catch(error => console.log(error))
            } else {
                return alert("Votre mot de passe ne peux pas comporter moins de 8 caractères !")
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

                                    <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
                                    <p class="text-white-50 mb-5">Connecter vous!</p>

                                    <div class=" form-floating mb-4">
                                        <input type="email" id="typeEmailX" class="form-control bg-white"
                                            placeholder=" " v-model="user.email" required />
                                        <label class="text-dark" for="typeEmailX">Email</label>
                                    </div>

                                    <div class="form-outline form-floating form-white mb-4">
                                        <input type="password" id="typePasswordX" class="form-control bg-white"
                                            placeholder=" " v-model="user.password" required />
                                        <label class="form-label text-dark" for="typePasswordX">Password</label>
                                    </div>

                                    <button class="btn btn-outline-light btn-lg px-5" type="submit"
                                        v-on:click="login()">Login</button>

                                </div>

                                <div>
                                    <p class="mb-0">Vous ne possèdez pas de compte?
                                        <router-link to="/RegisterUser" class="text-success fw-bold">
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
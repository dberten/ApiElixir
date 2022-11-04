<script>

import axios from 'axios'

export default {
    props: {},
    data() {
        return {
            users: [],
            form: {
                userId: null,
                username: "",
                email: ""
            },
            isFormSubmitted: false,
            dispFormLogin: true,
            errorMsg: null,
            isUserLogged: false
        }
    },
    methods: {
        async createUser() {
            const baseURI = 'http://localhost:4000/api/users'

            try {
                await axios.post(baseURI,
                    {
                        "user": {
                            "username": this.users.username,
                            "email": this.users.email
                        }
                    }).then((result) => {
                        // console.log(result.data.error)
                        if (!result.data.error) {
                            this.errorMsg = null
                            this.isFormSubmitted = true

                            localStorage.setItem('s_userId', result.data.data.id)
                            // console.log(result.data.id)
                            this.$router.push({
                                name: 'Mes Heures',
                                params: { userId: result.data.data.id }
                            });  
                        }
                    })
            }
            catch (err) {
                if (err.response) {
                    this.errorMsg = err.response.data.errors.email[0];
                }
            }
        },
        async updateUser(id, username, email) {
            const baseURI = 'http://localhost:4000/api/users/' + id
            await axios.put(baseURI,
                {
                    "user": {
                        "username": username,
                        "email": email
                    }
                })
            // TODO Alert Success
        },
        async getUser() {
            const baseURI = 'http://localhost:4000/api/users/' + localStorage.getItem('s_userId')
            await axios.get(baseURI)
                .then((result) => {
                    this.users = result.data
                })
        },
        async getUserByEmail() {
            const baseURI = 'http://localhost:4000/api/users?email=' + this.users.email + '&username=' + this.users.username
            await axios.get(baseURI)
                .then((result) => {
                    if (!result.data.errors) {
                        this.users = result.data

                        localStorage.setItem('s_userId', result.data.data.id)

                        this.$router.push({
                            name: 'Mes Heures',
                            params: { 'userId': result.data.data.id }
                        });
                    }
                })
        },
        async deleteUser(id) {
            const baseURI = 'http://localhost:4000/api/users/' + id
            await axios.delete(baseURI)
            // TODO Redirect
        },
        switchForm(val) {
            this.dispFormLogin = val;
        }
    },
    mounted() {
        let storeU = localStorage.getItem('s_userId')
        console.log(storeU)

        if (storeU) {
            this.getUser()
        }
    }
}

</script>

<template>
    <div class="container text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <div v-if="isUserLogged == false">
                <div v-if="dispFormLogin">
                    <h1> Se Connecter </h1>

                    <p> {{ users.error }}</p>
                    <p>
                        <label for="username">username</label>
                        <input id="username" v-model="users.username" type="text" name="username">
                    </p>
                    <p>
                        <label for="email">email</label>
                        <input id="email" v-model="users.email" type="text" name="email">
                    </p>

                    <button @click="getUserByEmail" class="btn btn-success">Ajouter</button>
                    <button @click="switchForm(false)" class="btn btn-success">Créer un compte?</button>
                </div>

                <div v-else>

                    <h1> Créer un compte </h1>
                    <p> {{ errorMsg }}</p>

                    <p>
                        <label for="username2">username</label>
                        <input id="username2" v-model="users.username" type="text" name="username2">
                    </p>
                    <p>
                        <label for="email2">email</label>
                        <input id="email2" v-model="users.email" type="text" name="email2">
                    </p>

                    <button @click="createUser" class="btn btn-success">Ajouter</button>
                    <button @click="switchForm(true)" class="btn btn-success">Déjà un compte?</button>

                </div>
            </div>
            <div v-else>
                <h1> Créer un compte </h1>
                <p> {{ errorMsg }}</p>

                <p>
                    <label for="username2">username</label>
                    <input id="username2" v-model="users.username" type="text" name="username2">
                </p>
                <p>
                    <label for="email2">email</label>
                    <input id="email2" v-model="users.email" type="text" name="email2">
                </p>

                <button @click="updateUser" class="btn btn-success">Modifier</button>
                <button @click="deleteUser" class="btn btn-success">Supprimer</button>
            </div>
        </div>
    </div>
</template>
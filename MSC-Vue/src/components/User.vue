<script>

import axios from 'axios'

export default {
  props : {  },
  data() {
    return {
        users: [],
        form: {
            userId: null,
            username: "",
            email: ""
        },
        form2: {
            userId: null,
            username: "",
            email: ""
        },
		submittedCreate: false,
    }
  },
  methods : {
    async createUser() {
        const baseURI = 'http://localhost:4000/api/users'
        await axios.post(baseURI,
        {
            "user": {
                "username": this.users.username, 
                "email": this.users.email
            }
        }).then((result) => {
			console.log(result.data.error)
			if (!result.data.error) {
				this.form.email = this.users.email
				this.form.username = this.users.username

				this.submittedCreate = true
			}
        }
                
            )
        // TODO Redirect 
    },
    async updateUser(id, username, email) {
        const baseURI = 'http://localhost:4000/api/users/'+id
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
        const baseURI = 'http://localhost:4000/api/users/'+this.form.userId
        await axios.get(baseURI)
        .then((result) => {
            this.users = result.data
        })
    },
    async getUserByEmail() {
        const baseURI = 'http://localhost:4000/api/users?email='+this.form.email+'&username='+this.form.username
        await axios.get(baseURI)
        .then((result) => {
            this.users = result.data

			if (!result.data.error) {
				localStorage.setItem('userId', this.users.data.id)
				//console.log(localStorage.getItem('userId'))
/*
				this.$router.push({ 
					name: 'Mes Heures',
					params: { userId: this.userId }
				});
*/
			}
        })
    },
    async deleteUser(id) {
        const baseURI = 'http://localhost:4000/api/users/'+id
        await axios.delete(baseURI)
        // TODO Redirect
    }
  }
}

</script>

<template>
    <div class="container text-color-Wsoft">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Où?</h1>
			<div v-for="user in users" :key="users.id">
				<h1> {{ user.username }}</h1> {{ idUser = user.id }}
				<p> {{ user.email }}</p>
				<p> {{ users.error }}</p>
			</div>

			<form v-on:submit.prevent="getUserByEmail()" id="app" @submit="getUserByEmail()">

					<p>
						<label for="username">username</label>
						<input id="username" v-model="form.username" type="text" name="username">
					</p>
					<p>
						<label for="email">email</label>
						<input id="email" v-model="form.email" type="text" name="email">
					</p>
					<p>
						<input type="submit" value="Submit">
					</p>
				</form>
        </div>
    </div>
	<p> {{ users.error }}</p>
		<div class="container text-color-Wsoft mt-5">
			<div class="black-soft rounded w-100 p-5 text-center">
				<h1>Form </h1>
				<p>
					<label for="username2">username</label>
					<input id="username2" v-model="users.username" type="text" name="username2">
				</p>
				<p>
					<label for="email2">email</label>
					<input id="email2" v-model="users.email" type="text" name="email2">
				</p>
				<button @click="createUser" class="btn btn-success">Submit</button>
			</div>
        </div>
	<div v-if="submittedCreate">
      <h4>Success! You are now logged as :</h4>
	  <div v-for="user in users" :key="users.id">
				<h1> {{ user.username }}</h1> {{ idUser = user.id }}
				<p> {{ user.email }}</p>
				<p> {{ users.error }}</p>
			</div>
    </div>
</template>
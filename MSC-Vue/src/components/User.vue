<script>

import axios from 'axios'

export default {
  props : {  },
  data() {
    return {
      users: []
    }
  },
  methods : {
    async createUser(username, email) {
        const baseURI = 'http://localhost:4000/api/users'
        await axios.post(baseURI,
        {
            "user": {
                "username": username, 
                "email": email
            }
        })
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
    async getUser(id) {
        const baseURI = 'http://localhost:4000/api/users/'+id
        await axios.get(baseURI)
        .then((result) => {
            this.users = result.data
            // console.log(result.data)
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
                    <h1> {{ user.username }}</h1>
                    <p> {{ user.email }}</p>
                </div>
            <button @click="createUser('Test2', 't2est@gmail.com')" >Click me!</button>
        </div>
    </div>
    <div class="container text-color-Wsoft mt-5">
        <div class="black-soft rounded w-100 p-5 text-center">
            <h1>Météo actuelle à </h1>
            
        </div>
    </div>
</template>
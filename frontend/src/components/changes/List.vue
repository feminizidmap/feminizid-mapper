<template>
  <div class="changes">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <h3>Recent changes</h3>
    <input class="form-control"
           autofocus autocomplete="off"
           placeholder="What is the status?"
           v-model="newChange"
           @keyup.enter="addChange" />
    <br />
    <ul class="list-group">
      <li class="list-group-item"
          v-for="change in changes"
          :key="change.id"
          :change="change">
        <div v-show="change != editedChange" @dblclick="editChange(change)">
          <label>{{ change.status }} by {{ change.user_id}} on {{ change.created_at}}</label>
          <i class="fa fa-trash-alt" @click="removeChange(change)"></i>
        </div>
        <div v-show="change == editedChange">
          <input class="form-control"
                 v-change-focus
                 @blur="updateChange(change)"
                 @keyup.enter="updateChange(change)"
                 v-model="change.status"
          />
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
 export default {
   name: 'List',
   data () {
     return {
       changes: [],
       newChange: [],
       error: '',
       editedChange: ''
     }
   },
   created () {
     if (!this.$store.state.signedIn) {
       this.$router.replace('/')
     } else {
       this.$http.secured.get('/changes')
           .then(response => { this.changes = response.data })
           .catch(error => this.setError(error, 'Something went wrong'))
     }
   },
   methods: {
     setError (error, text) {
       this.error = (error.response && error.response.data && error.response.data.error) || text
     },
     addChange() {
       const value = this.newChange && this.newChange.trim()
       if (!value) {
         return
       }
       this.$http.secured.post('/changes', { change: { status: this.newChange } })
           .then(response => {
             this.changes.push(response.data)
             this.newChange = ''
           })
           .catch(error => this.setError(error, 'Cannot create change'))
     },
     removeChange(change) {
       this.$http.secured.delete(`/changes/${change.id}`)
           .then(() => {
             this.changes.splice(this.changes.indexOf(change), 1)
           })
           .catch(error => this.setError(error, 'Cannot delete change'))
     },
     editChange(change) {
       this.editedChange = change
     },
     updateChange(change) {
       this.editedChange = ''
       this.$http.secured.patch(`/changes/${change.id}`, { change: { status: change.status } })
           .catch(error => this.setError(error, 'Cannot update change'))
     }
   },
   directives: {
     'change-focus': function (el) {
       el.focus()
     }
   }
 }
</script>

<style lang="css">
 .changes ul li i.fa.fa-trash-alt {
   visibility: hidden;
   margin-top: 5px;
 }
 .changes ul li:hover {
   background: #fcfcfc;
 }
 .changes ul li:hover i.fa.fa-trash-alt {
   visibility: visible;
 }
</style>

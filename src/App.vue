<template>
  <div id="app">
    <Form v-on:childToParent="searchForMovie"/>
    <Display v-if="currentMovieData" :movie="currentMovieData" />
  </div>
</template>

<script>
import Form from './components/Form.vue'
import Display from './components/Display.vue'

export default {
  name: 'app',
  data() {
    return {
      url: "http://www.omdbapi.com/?apikey=c63f2a17&t=",
      currentMovieData: {}
      // apiKey: ""
    }
  },
  components: {
    Form,
    Display
  },
  methods: {
    searchForMovie(title){ 
      let fullUrl = this.url + title;
      fetch(fullUrl, {
          mode: 'cors',
          method: 'GET'

      })
      .then(res => res.json())
      .then(data=>{
        this.currentMovieData = data
      })
        

    }

  }

}


</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

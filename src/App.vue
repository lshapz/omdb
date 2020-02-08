<template>
  <div id="app">
    <SearchForm v-on:childToParent="searchForMovie"/>
    <Display v-if="currentMovieData" :movie="currentMovieData" />
    <SaveForm v-if="currentMovieData" v-on:childToParent="saveUserRating" />
  </div>
</template>

<script>
import SearchForm from './components/SearchForm.vue'
import Display from './components/Display.vue'
import SaveForm from './components/SaveForm.vue'

export default {
  name: 'app',
  data() {
    return {
      url: "http://www.omdbapi.com/?apikey=c63f2a17&t=",
      currentMovieData: null
      // apiKey: ""
    }
  },
  components: {
    SearchForm,
    Display,
    SaveForm
  },
  methods: {
    searchForMovie(title){ 
      let fullUrl = this.url + title;
      console.log(fullUrl);
      fetch(fullUrl, {
          mode: 'cors',
          method: 'GET'

      })
      .then(res => res.json())
      .then(data=>{
        this.currentMovieData = data
      })
        

    },
    saveUserRating(comment, rating) {
      console.log(comment);
      console.log(rating);

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

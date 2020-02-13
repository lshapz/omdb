<template>
  <div id="app">
    <SearchForm v-on:childToParent="searchForMovie"/>
    <div v-if="currentMovieData && !savingMovie" class="flexMovies">
      <Display  v-for="movie in currentMovieData" :opt="true" :movie="movie" :key="movie['imdbID']" v-on:childToParent="saveMovie" />

    </div>
    <div v-if="savingMovie" >
      <Display :movie="savingMovie" />
      <SaveForm v-on:childToParent="saveUserRating" />
    </div>

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
      url: "http://www.omdbapi.com/?apikey=c63f2a17&s=",
      currentMovieData: null,
      savingMovie: null,
      true: true
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
      this.currentMovieData = null;
      this.savingMovie = null;
      console.log(fullUrl);
      fetch(fullUrl, {
          mode: 'cors',
          method: 'GET'
      })
      .then(res => res.json())
      .then(data=>{
        this.currentMovieData = data["Search"]
      })

    },
    saveMovie(movie) {
      this.savingMovie = movie;
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
.flexMovies {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.flexMovies > * {
   margin: 20px;
  padding: 20px;
}
</style>

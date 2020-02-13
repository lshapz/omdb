<template>
  <div id="app">
    <SearchForm v-on:childToParent="searchForMovie"/>
    <div> 
      <button @click="showMovies">Show Saved Movies</button>
    </div>

    <div v-if="currentMovieData && !savingMovie" class="flexMovies">
      <Display v-for="movie in currentMovieData" :solo="solo" :opt="newFilms" :movie="movie" :key="movie['imdbID']" v-on:childToParent="saveMovie" />

    </div>
    <div v-if="savingMovie" >
      <Display :movie="savingMovie" :opt="false" :solo="solo" />
      <SaveForm v-on:childToParent="saveUserRating" :newFilms="newFilms" :savedRating="rating" v-on:deleteFromParent="deleteRecord" />
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
      omdburl: "http://www.omdbapi.com/?apikey=c63f2a17&s=",
      sinatraurl: "http://localhost:9393/movies",
      currentMovieData: null,
      savingMovie: null,
      newFilms: true
    }
  },
  components: {
    SearchForm,
    Display,
    SaveForm
  },
  computed: {
    solo() {
      return !!this.savingMovie
    },
    rating() {
      return this.savingMovie.rating || 1
    }
  },
  methods: {
    searchForMovie(title){ 
      let fullUrl = this.omdburl + title;
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
    showMovies() {
      fetch(this.sinatraurl + "/", {   
        method: 'GET', 
        "Access-Control-Allow-Origin" : "localhost:8081", 
        "Access-Control-Allow-Credentials" : true,
        headers: {
          "Content-Type": "application/json"
        }
      })
      .then((response)=> response.json())
      .then((myJson) => {
          this.currentMovieData = myJson;
          this.newFilms = false;
      });

    },
    deleteRecord() {
      let url = this.sinatraurl + "/" + this.savingMovie.id
        fetch(url, {
            method: 'DELETE', 
            mode: 'cors', 
            headers: { "Content-Type": "application/json"}
          })
        .then(()=>{
          this.currentMovieData = null;
          this.savingMovie = null;
        })
    },
    
    saveMovie(movie) {
      this.savingMovie = movie;
    },
    saveUserRating(comment, rating) {
      if (this.newFilms) {
        let data = {
          title: this.savingMovie.Title,
          year: this.savingMovie.Year,
          poster: this.savingMovie.Poster,
          comment: comment,
          rating: rating
        }

        fetch(this.sinatraurl, {
            method: 'POST', 
            mode: 'no-cors', 
            body: JSON.stringify(data), 
            "Access-Control-Allow-Origin" : "*", 
            "Access-Control-Allow-Credentials" : true,
            headers: {"Content-Type": "application/json"}
        })
        .then(()=>{
          this.currentMovieData = null;
          this.savingMovie = null;
        })
      } else {
        let data = {comment, rating} 
        let url = this.sinatraurl + "/" + this.savingMovie.id
        fetch(url, {
            method: 'PUT', 
            mode: 'cors', 
            body: JSON.stringify(data), 
            headers: { "Content-Type": "application/json"}
          })
        .then(()=>{
          this.currentMovieData = null;
          this.savingMovie = null;
        })

      }
         
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

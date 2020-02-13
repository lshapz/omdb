<template>
  <div class="display">
    <h3>{{movieTitle}} ({{movieYear}}) </h3>
    <h4 v-if="movie.rating">Your Rating: {{movie.rating}}</h4>
    <img :src="posterPresent">
    <div v-if="opt"> 
      <button @click="saveMovie">Save Movie</button>
    </div>
    <div v-if="!solo && !opt"> 
      <button @click="saveMovie">Update Movie</button>
    </div>

    <blockquote v-if="movie.comment">{{movie.comment}}</blockquote> 
  </div>
</template>

<script>
export default {
  name: 'Display',
  props: {
    movie: Object,
    opt: {
      type: Boolean,
      default: false
    },
    solo: {
      type: Boolean,
      default: false
    },
  },
  computed: {
    posterPresent() {
      if (this.movie.Poster == 'N/A'){
        return "https://via.placeholder.com/300x422?text=No%20Poster%20Found"
      } 
      // else if  (this.movie.poster && this.movie.poster == null) {
      //   console.log(this.movie.poster);
      //   return "https://via.placeholder.com/300x422?text=No%20Poster%20Found"
      // }
       else {
        return this.movie.Poster || this.movie.poster;
      }
    },
    // moviePoster() {
    //   return this.movie.Poster || this.movie.poster
    // },
    movieTitle() {
      return this.movie['Title'] || this.movie.title
    },
    movieYear() {
      return this.movie['Year'] || this.movie.year
    }

  },
  methods: {
    saveMovie(event) {
      event.preventDefault()
      this.$emit('childToParent', this.movie)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>

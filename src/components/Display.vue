<template>
  <div class="display">
    <h3>{{movie['Title']}} ({{movie['Year']}}) </h3>
    <img :src="posterPresent">
    <div v-if="opt"> 
      <button @click="saveMovie">Save Movie</button>
    </div>
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
    }
  },
  computed: {
    posterPresent() {
      if (this.movie.Poster == 'N/A'){
        return "https://via.placeholder.com/300x422?text=No%20Poster%20Found"
      } else {
        return this.movie.Poster;
      }
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

<template>
  <div class="display">
    <h1>{{movie['Title']}} ({{movie['Year']}}) </h1>
    <img :src="movie['Poster']">
    <!-- If there is no poster, please put a placeholder image instead -->

    <blockquote>
      {{movie['Plot']}}
    </blockquote>
  </div>
</template>

<script>
export default {
  name: 'Display',
  props: {
    movie: Object
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

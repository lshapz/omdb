<template>
<form>
    <div> 
        <label for="search">Search For A Movie Title</label>
    </div>
    <div> 
        <input type="text" name="search" v-model="titleSearch"> 
    <!-- </div>   
    <div>  -->
        <button type="submit" @click="onSubmit">Submit</button>
    </div>
</form>
</template>

<script>
export default {
    data: function(){
        return{
            titleSearch: ""
        }
    },
    methods: {
        onSubmit(event){
            event.preventDefault();
            this.$emit('childToParent', this.titleSearch);

        }
    }
}

</script>


<style>
</style>

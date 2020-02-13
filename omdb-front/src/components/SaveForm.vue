/* eslint-disable no-debugger */
<template>
<div>
    <div> 
    <label for="comments">Comments?</label>
        </div>
    <textarea form="myForm" name="comments" v-model="comment" />

    <form id="myForm">
        <div> 
            <label for="rating">Rate this film 1-5</label>
                
            <select v-model="rating" name="rating">
                <option v-for="n in 5" :key="n"> {{n}} </option>
            </select>
        </div>
        <div> 
            <button type="submit" @click="onSubmit">
                <span v-if="newFilms">Submit Rating</span>
                <span v-else>Update Rating</span>
            </button>
            <button v-if="!newFilms" @click="onDelete"> 
                Delete Movie
            </button>
        </div>
    </form>

    </textarea>
</div>
</template>

<script>
export default {
    props: {
        newFilms: Boolean,
        savedRating: Number
    },
    data: function(){
        return{
            rating: this.savedRating,
            comment: ""
        }
    },
    methods: {
        onSubmit(event){
            event.preventDefault();
            this.$emit('childToParent', this.comment, this.rating);
        },
        onDelete(event) {
            event.preventDefault();
            this.$emit('deleteFromParent')
        }
    }
}

</script>


<style>

select {
    margin-left: 10px;
}
</style>

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
            <button type="submit" @click="onSubmit">Submit</button>
        </div>
    </form>

    </textarea>
</div>
</template>

<script>
export default {
    data: function(){
        return{
            rating: 3,
            comment: ""
        }
    },
    methods: {
        onSubmit(event){
            event.preventDefault();
            // eslint-disable-next-line no-debugger
            debugger
            this.$emit('childToParent', this.titleSearch);

        }
    }
}

</script>


<style>

select {
    margin-left: 10px;
}
</style>

<template>
  <div class="">
    <draggable
      :list="list1"
      tag="div"
      itemKey="id"
      class="flex flex-wrap flex-row container mx-auto px-4 overflow-auto"
    >
      <template #item="{ element }">
        <div class="border flex-1 basis-72 w-1/5">{{ element }}</div>
      </template>
    </draggable>
  </div>

  <!-- <div class="flex">
      <h3>Draggable 2</h3>
      <draggable class="list-group" :list="list2" group="people" itemKey="id">
        <template #item="{ element, index }">
          <div class="list-group-item">{{ element.name }} {{ index }}</div>
        </template>
      </draggable>
    </div> -->

  {{ list1 }}
</template>

<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'
import axios from 'axios'

const list1 = ref([])

// read json
const a = axios.get('faces.json').then(
  (value) => {
    console.log(value)

    type FaceInfo = (typeof value.data)[0]

    list1.value = value.data.map((v: FaceInfo) => v.category)

    const a: FaceInfo = null
  },
  (reason) => console.log(reason),
)

console.log(a)

// build datastructure

// const list1 = ref([
//   { name: 'JohnJohnJohnJohn', id: 1 },
//   { name: 'Joao', id: 2 },
//   { name: 'JeanJeanJeanJeanJeanJeanJean', id: 3 },
//   { name: 'GerardGerardGerard', id: 4 },
// ])
</script>

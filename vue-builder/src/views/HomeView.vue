<template>
  <div class="" v-for="x in list1" :key="x.category">
    <br />
    <h1>{{ x.category }}</h1>
    <draggable
      :list="x.faces"
      tag="div"
      itemKey="id"
      class="container mx-auto flex flex-row flex-wrap overflow-auto px-4"
    >
      <template #item="{ element }">
        <div class="w-1/5 flex-1 basis-72 border" :tooltip="element.doc">
          {{ element.face }}
        </div>
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

  <br />
  <br />
  -------------------------------
  <br />
  {{ list1 }}
</template>

<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'
import axios from 'axios'

interface FaceInfo {
  face: string
  doc: string
}
interface FaceCategory {
  category: string
  faces: FaceInfo[]
}

const list1 = ref([])

// read json
const a = axios.get('faces.json').then(
  (value) => {
    console.log(value)

    list1.value = value.data
    //.map((v: Facecategory) => v.category)
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

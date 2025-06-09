<template>
  <div class="" v-for="cat in allFaces" :key="cat.category">
    <br />
    <h1 class="text-3xl font-bold capitalize">{{ cat.category }}</h1>
    <draggable
      :list="cat.faces"
      tag="div"
      :group="{ name: 'faces', put: false }"
      itemKey="x.category"
      class="flex flex-row flex-wrap overflow-auto px-4"
    >
      <template #item="{ element }">
        <div class="p-1" :tooltip="element.doc">
          <TooltipProvider>
            <Tooltip>
              <TooltipTrigger
                ><Badge>{{ element.face }}</Badge></TooltipTrigger
              >
              <TooltipContent>
                <pre>{{ element.doc }}</pre>
              </TooltipContent>
            </Tooltip>
          </TooltipProvider>
        </div>
      </template>
    </draggable>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'
import axios from 'axios'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip'
import { Badge } from '@/components/ui/badge'

interface FaceInfo {
  face: string
  doc: string
}
interface FaceCategory {
  category: string
  faces: FaceInfo[]
}

const allFacesInit: FaceCategory[] = []

const allFaces = ref(allFacesInit)

// read json
const a = axios.get('faces.json').then(
  (value) => {
    console.log(value)

    allFaces.value = value.data
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

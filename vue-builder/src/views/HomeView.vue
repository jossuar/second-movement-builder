<template>
  <p>Sensor Watch Builder</p>
  Build firmware for the Sensor Watch online. Currently building from Source code on GitHub.

  <div class="grid grid-cols-3 gap-4">
    <div>
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
    </div>
    <div>
      <form class="w-2/3 space-y-6" @submit="onSubmit">
        <FormField v-slot="{ componentField }" name="boardColor">
          <FormItem>
            <FormLabel>Config</FormLabel>
            <Select v-bind="componentField">
              <FormControl>
                <SelectTrigger>
                  <SelectValue placeholder="Choose a Board color" />
                </SelectTrigger>
              </FormControl>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Fruits</SelectLabel>
                  <SelectItem value="sensorwatch_red"> Red </SelectItem>
                  <SelectItem value="sensorwatch_green"> Green </SelectItem>
                  <SelectItem value="sensorwatch_blue"> Blue </SelectItem>
                  <SelectItem value="sensorwatch_pro"> Pro </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <FormDescription>
              You can manage email addresses in your
              <a href="/examples/forms">email settings</a>.
            </FormDescription>
            <FormMessage />
          </FormItem>
        </FormField>

        <Button type="submit" @submit="onSubmit"> Submit </Button>
      </form>
    </div>
    <div class="border">03</div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import draggable from 'vuedraggable'
import axios from 'axios'

import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'
import * as z from 'zod'

import { Badge } from '@/components/ui/badge'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip'
import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import {
  Select,
  SelectLabel,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { toast } from 'vue-sonner'

const formSchema = toTypedSchema(
  z.object({
    boardColor: z.string({
      required_error: 'Please select the board color.',
    }),
  }),
)

const { handleSubmit } = useForm({
  validationSchema: formSchema,
})

const onSubmit = handleSubmit((values) => {
  toast('Event has been created', {
    description: 'Sunday, December 03, 2023 at 9:00 AM',
    action: {
      label: 'Undo',
      onClick: () => console.log(values),
    },
  })
})

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

const a = axios.get('faces.json').then(
  (value) => {
    allFaces.value = value.data
  },
  (reason) => console.log(reason),
)

console.log(a)

// build datastructure
</script>

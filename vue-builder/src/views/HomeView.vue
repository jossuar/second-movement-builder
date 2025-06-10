<template>
  <p>Sensor Watch Builder</p>
  Build firmware for the Sensor Watch online. Currently building from Source code on GitHub.
  <br />
  <br />
  <div class="grid grid-cols-3 gap-4">
    <div>
      <div class="" v-for="cat in allFaces" :key="cat.category">
        <p class="font-medium capitalize">{{ cat.category }}</p>
        <draggable
          :list="cat.faces"
          tag="div"
          :group="{ name: 'faces', put: false }"
          :itemKey="cat.category"
          class="flex flex-row flex-wrap overflow-auto px-4"
        >
          <template #item="{ element }">
            <div class="p-1" :tooltip="element.doc">
              <TooltipProvider :disableHoverableContent="true">
                <Tooltip>
                  <TooltipTrigger as="div"
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
      <form class="space-y-6" @submit="onSubmit">
        <FormField v-slot="{ componentField }" name="boardColor">
          <FormItem>
            <FormLabel>Board Color</FormLabel>
            <Select v-bind="componentField" defaultValue="sensorwatch_red">
              <FormControl>
                <SelectTrigger>
                  <SelectValue placeholder="Select the Board" />
                </SelectTrigger>
              </FormControl>
              <SelectContent>
                <SelectItem value="sensorwatch_red"> Red </SelectItem>
                <SelectItem value="sensorwatch_green"> Green </SelectItem>
                <SelectItem value="sensorwatch_blue"> Blue </SelectItem>
                <SelectItem value="sensorwatch_pro"> Pro </SelectItem>
              </SelectContent>
            </Select>
            <FormMessage />
          </FormItem>
        </FormField>

        <FormField v-slot="{ componentField }" name="displayType">
          <FormItem>
            <FormLabel>Display</FormLabel>
            <Select v-bind="componentField" defaultValue="classic">
              <FormControl>
                <SelectTrigger>
                  <SelectValue placeholder="Select the Display" />
                </SelectTrigger>
              </FormControl>
              <SelectContent>
                <SelectItem value="classic"> Classic </SelectItem>
                <SelectItem value="custom"> Custom </SelectItem>
              </SelectContent>
            </Select>
            <FormMessage />
          </FormItem>
        </FormField>

        <FormField v-slot="{ componentField }" name="signalTune">
          <FormItem>
            <FormLabel>Signal Tune (hourly)</FormLabel>
            <Select v-bind="componentField" defaultValue="SIGNAL_TUNE_DEFAULT">
              <FormControl>
                <SelectTrigger>
                  <SelectValue placeholder="Select the Signal Tune" />
                </SelectTrigger>
              </FormControl>
              <SelectContent>
                <SelectItem value="SIGNAL_TUNE_DEFAULT"> Default </SelectItem>
                <SelectItem value="SIGNAL_TUNE_ZELDA_SECRET"> Zelda Secret Sound </SelectItem>
                <SelectItem value="SIGNAL_TUNE_MARIO_THEME"> Mario </SelectItem>
                <SelectItem value="SIGNAL_TUNE_KIM_POSSIBLE"> Kim Possible </SelectItem>
              </SelectContent>
            </Select>
            <FormMessage />
          </FormItem>
        </FormField>

        <p class="font-medium capitalize">Primary Faces</p>
        <draggable
          :list="primaryFaces"
          tag="div"
          :group="{ name: 'faces' }"
          itemKey="primary"
          class="flex flex-row flex-wrap overflow-auto border px-4"
        >
          <template #item="{ element }">
            <div class="p-1" :tooltip="element.doc">
              <TooltipProvider :disableHoverableContent="true">
                <Tooltip>
                  <TooltipTrigger as="div"
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

        <p class="font-medium capitalize">Secondary Faces</p>
        <draggable
          :list="secondaryFaces"
          tag="div"
          :group="{ name: 'faces' }"
          itemKey="secondary"
          class="flex w-full flex-row flex-wrap overflow-auto border px-4"
        >
          <template #item="{ element }">
            <div class="p-1" :tooltip="element.doc">
              <TooltipProvider>
                <Tooltip>
                  <Badge>{{ element.face }}</Badge>
                  <TooltipContent>
                    <pre>{{ element.doc }}</pre>
                  </TooltipContent>
                </Tooltip>
              </TooltipProvider>
            </div>
          </template>
        </draggable>

        <Button type="submit" @submit="onSubmit"> Submit </Button>
      </form>
    </div>

    <div class="border">
      <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur euismod ipsum erat, eget
        tincidunt nunc faucibus ut. Aenean elementum tellus eu ex pellentesque, quis luctus diam
        commodo. Aliquam justo nisl, gravida a neque in, lacinia pharetra tortor. Aenean elementum
        tellus ac dictum ullamcorper. Nulla eget eros in diam elementum volutpat. Donec tristique
        posuere libero a porttitor. Nam ultricies odio et hendrerit aliquet.
      </p>
      <p>
        Nulla egestas enim urna, quis condimentum dui pulvinar a. Vestibulum vehicula vestibulum
        massa vitae varius. Vivamus lacinia dui a mauris laoreet, vel efficitur tellus sollicitudin.
        Ut eleifend, sem sit amet vehicula tincidunt, lectus dolor convallis massa, ut vulputate
        elit metus eleifend ante. Morbi iaculis nisi in nulla pulvinar euismod. Donec gravida sapien
        ut sem accumsan, in varius lacus congue. Pellentesque laoreet nibh nec ligula egestas, in
        dictum mauris aliquam. Vestibulum imperdiet lectus ligula, eu tempus dui pharetra id. Nulla
        molestie aliquet mauris ac auctor. Integer id lacinia est, vel tristique felis. Vivamus
        justo nunc, semper ut imperdiet eget, euismod ac ex.
      </p>
      <p>
        Suspendisse potenti. Praesent sollicitudin lorem eu erat bibendum faucibus. Sed gravida,
        felis et egestas feugiat, libero tellus suscipit lectus, in euismod eros lacus ac risus.
        Morbi et purus quis dui varius aliquam. Curabitur et nisi id leo vehicula finibus. Ut a
        mattis ex, in volutpat velit. Phasellus aliquet sapien sed maximus suscipit. Maecenas
        consectetur ligula at ante iaculis, vel eleifend lectus varius. Nullam placerat lobortis
        quam at vestibulum. Etiam at imperdiet libero, ac imperdiet magna. Morbi vehicula felis
        metus, tincidunt vehicula nunc tincidunt ac. Nam id elit nec metus interdum consequat. Sed
        egestas tellus eget rutrum accumsan.
      </p>
      <p>
        In maximus arcu est. Quisque et tincidunt arcu. Aenean cursus nulla non rutrum condimentum.
        Sed fermentum tempus diam, semper malesuada erat pharetra et. Aliquam rhoncus fermentum eros
        quis suscipit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam
        lobortis, enim id sodales convallis, tortor urna posuere erat, id facilisis urna urna a
        urna. Nullam laoreet eros vel dolor suscipit, id tristique sem dictum. Nullam consectetur
        sem vel fringilla placerat. Fusce facilisis non est id sollicitudin. Nullam elementum libero
        non tortor posuere euismod. Class aptent taciti sociosqu ad litora torquent per conubia
        nostra, per inceptos himenaeos. Integer rutrum sem a lectus euismod, vel porta nisl semper.
        Donec suscipit dui id nibh elementum tincidunt.
      </p>
    </div>
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
import { FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { toast } from 'vue-sonner'

const formSchema = toTypedSchema(
  z.object({
    boardColor: z.string({
      required_error: 'Please select your board color.',
    }),
    displayType: z.string({
      required_error: 'Please select your display type.',
    }),
    signalTune: z.string({
      required_error: 'Please select the desired signal tune.',
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
      onClick: () => {
        console.log(values)
        console.log(primaryFaces.value.map((e) => e.face))
        console.log(secondaryFaces.value.map((e) => e.face))
      },
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

const primaryFacesInit: FaceInfo[] = []
const secondaryFacesInit: FaceInfo[] = []

const primaryFaces = ref(primaryFacesInit)
const secondaryFaces = ref(secondaryFacesInit)

const a = axios.get('faces.json').then(
  (value) => {
    allFaces.value = value.data
  },
  (reason) => console.log(reason),
)

console.log(a)

// build datastructure
</script>

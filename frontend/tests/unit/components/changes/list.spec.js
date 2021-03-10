import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import List from '@/components/changes/List.vue'

//import MockLocalStorage from '../../../helpers/mockingLocalStorage.js'

describe('List.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(List, {
        })
        expect(wrapper.find('input').element).to.exist;
    })
    it.skip('renders a list', () => {
        //const wrapper = shallowMount(List)

    })
    it.skip('renders a delete button', () => {
        //const wrapper = shallowMount(List)
    })
})

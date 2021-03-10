import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Signup from '@/views/Signup.vue'

describe('Signup.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(Signup, {
        })
        expect(wrapper.find('input').element).to.exist;
    })
})

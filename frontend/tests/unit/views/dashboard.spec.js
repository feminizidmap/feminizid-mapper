import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Dashboard from '@/views/Dashboard.vue'

describe('Dashboard.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(Dashboard, {
        })
        expect(wrapper.find('h1').element).to.exist;
    })
})

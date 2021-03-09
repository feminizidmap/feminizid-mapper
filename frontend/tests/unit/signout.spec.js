import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Signout from '@/components/Signout.vue'

describe('Signout.vue', () => {
    it('renders a button', () => {
        const wrapper = shallowMount(Signout)
        expect(wrapper.find('button').element).to.exist;
    })
    it.skip('renders an error when singout fails', () => {
        const wrapper = shallowMount(Signout)
        expect(wrapper.find('button').element).to.exist;
    })
})

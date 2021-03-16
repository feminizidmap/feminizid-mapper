import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import ResetPassword from '@/views/ResetPassword.vue'

describe('ResetPassword.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(ResetPassword, {
        })
        expect(wrapper.find('input').element).to.exist;
    })
})

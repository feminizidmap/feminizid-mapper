import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import ForgotPassword from '@/views/ForgotPassword.vue'

describe('ForgotPassword.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(ForgotPassword, {
        })
        expect(wrapper.find('input').element).to.exist;
    })
})

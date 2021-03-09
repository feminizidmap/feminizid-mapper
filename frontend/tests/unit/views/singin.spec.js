import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Signin from '@/views/Signin.vue'

describe('Signin.vue', () => {
  it.skip('renders a form', () => {
    const wrapper = shallowMount(Signin, {
    })
    expect(wrapper.find('input').element).to.exist;
  })
})

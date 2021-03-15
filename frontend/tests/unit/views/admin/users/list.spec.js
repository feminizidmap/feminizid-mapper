import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import UsersList from '@/views/admin/users/List.vue'

describe('UsersList.vue', () => {
    it.skip('renders a form', () => {
        const wrapper = shallowMount(UsersList, {
        })
        expect(wrapper.find('h1').element).to.exist;
    })
})

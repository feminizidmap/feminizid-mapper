import CaseList from '@/views/cases/List'
import CaseSingle from '@/views/cases/Single'
import CaseForm from '@/views/cases/Form'
import CaseMeta from '@/views/cases/Meta'
import CaseCrime from '@/views/cases/Crime'

export default {
  path: '/cases/',
  name: 'Cases',
  component: () => import(/* webpackChunkName: "codelists" */ '@/views/Caselist.vue'),
  children: [
    {
      path: '',
      name: 'CaseList',
      component: CaseList
    },
    {
      path: 'new',
      name: 'CaseNew',
      component: CaseForm,
      children: [
        {
          path: '',
          name: 'CaseNewMeta',
          component: CaseMeta
        },
        {
          path: 'crime',
          name: 'CaseNewCrime',
          component: CaseCrime
        },
        {
          path: 'crime',
          name: 'CaseNewVictim',
          component: CaseCrime
        },
        {
          path: 'crime',
          name: 'CaseNewPerpetrator',
          component: CaseCrime
        }
      ]
    },
    {
      path: 'edit/:caseid',
      name: 'CaseEdit',
      component: CaseForm,
      children: [
        {
          path: '',
          name: 'CaseEditMeta',
          component: CaseMeta
        }
      ]
    },
    {
      path: ':caseid',
      name: 'CaseSingle',
      component: CaseSingle
    }
  ]
}

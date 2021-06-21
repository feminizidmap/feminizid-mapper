import CaseList from '@/views/cases/List'
import CaseSingle from '@/views/cases/Single'
import CaseNewForm from '@/views/cases/NewForm'
import CaseWizard from '@/views/cases/Wizard'
import CaseFinish from '@/views/cases/Finish'
import CaseMeta from '@/views/cases/Meta'
import CaseCrime from '@/views/cases/Crime'
import CaseVictim from '@/views/cases/Victim'
import CasePerp from '@/views/cases/Perpetrator'

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
      component: CaseNewForm,
      children: [
        {
          path: '',
          name: 'CaseNewWizard',
          component: CaseWizard
        },
        {
          path: 'finish',
          name: 'CaseNewFinish',
          component: CaseFinish
        },
        {
          path: 'meta',
          name: 'CaseNewMeta',
          component: CaseMeta
        },
        {
          path: 'crime',
          name: 'CaseNewCrime',
          component: CaseCrime
        },
        {
          path: 'victim',
          name: 'CaseNewVictim',
          component: CaseVictim
        },
        {
          path: 'perpetrator',
          name: 'CaseNewPerpetrator',
          component: CasePerp
        }
      ]
    },
    // {
    //   path: 'edit/:caseid',
    //   name: 'CaseEdit',
    //   component: CaseForm,
    //   children: [
    //     {
    //       path: '',
    //       name: 'CaseEditMeta',
    //       component: CaseMeta
    //     }
    //   ]
    // },
    {
      path: ':caseid',
      name: 'CaseSingle',
      component: CaseSingle
    }
  ]
}

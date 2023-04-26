import RecordList from '@/views/records/List'
import RecordSingle from '@/views/records/Single'
import RecordForm from '@/views/records/Form'
import RecordStart from '@/views/records/Start'
import RecordEntity from '@/views/records/RecordEntityForm'
import RecordFinish from '@/views/records/Finish'
import RecordMeta from '@/views/records/Meta'

export default {
  path: '/records/',
  name: 'records',
  component: () => import(/* webpackChunkName: "records" */ '@/views/RecordList.vue'),
  children: [
    {
      path: '',
      name: 'RecordList',
      component: RecordList
    },
    {
      path: 'new',
      name: 'RecordNew',
      component: RecordForm,
      children: [
        {
          path: '',
          name: 'RecordNewStart',
          component: RecordStart
        },
        {
          path: 'meta',
          name: 'RecordNewMeta',
          component: RecordMeta
        },
        {
          path: ':entityname',
          name: 'RecordNewEntity',
          component: RecordEntity
        },
        {
          path: 'finish',
          name: 'RecordNewFinish',
          component: RecordFinish
        }
      ]
    },
    {
      path: 'edit/:recordid',
      name: 'RecordEdit',
      component: RecordForm,
      children: [
        {
          path: '',
          name: 'RecordEditStart',
          component: RecordStart // TODO
        },
        {
          path: 'meta',
          name: 'RecordEditMeta',
          component: RecordMeta
        },
        {
          path: ':entityname',
          name: 'RecordEditEntity',
          component: RecordEntity
        },
        {
          path: 'finish',
          name: 'RecordEditFinish',
          component: RecordFinish
        }
      ]
    },
    {
      path: ':recordid',
      name: 'RecordSingle',
      component: RecordSingle
    }
  ]
}

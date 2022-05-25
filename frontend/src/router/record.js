import RecordsList from '@/views/records/List'
import RecordNew from '@/views/records/RecordNew'
import Record from '@/views/records/Record'

export default {
  path: '/records/',
  name: 'Records',
  component: () => import(/* webpackChunkName: "records" */ '@/views/Recordlist.vue'),
  children: [
    {
      path: '',
      name: 'RecordsList',
      component: RecordsList
    },
    {
      path: 'new',
      name: 'RecordNew',
      component: RecordNew,
    },
    {
      path: ':recordid',
      name: 'Record',
      component: Record
    }
  ]
}

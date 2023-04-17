<template>
  <div class="text-center border border-4 p-4 mt-auto">
    <div class="d-flex justify-content-between">
      <router-link v-if="activeStepIndex > 0" :to="steps[activeStepIndex - 1].link" class="btn btn-primary">
        <i class="fas fa-arrow-circle-left"></i>
        Zurück zu {{ steps[activeStepIndex - 1].name }}
      </router-link>

      <router-link v-if="activeStepIndex < steps.length - 1" :to="steps[activeStepIndex + 1].link" class="btn btn-primary">
        Weiter zu {{ steps[activeStepIndex + 1].name }}
        <i class="fas fa-arrow-circle-right"></i>
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "WizardControl",
  props: { steps: Array },
  computed: {
    activeStepIndex() {
      const currentRoute = this.$route;
      return this.steps.findIndex((step) => {
        if (step.link.name === currentRoute.name) {
          if (!step.link.params) {
            return true; // no params to compare, so this is the active step
          }
          const routeParams = currentRoute.params;
          const stepParams = step.link.params;

          if (
            stepParams.hasOwnProperty("entityname") &&
            routeParams.hasOwnProperty("entityname") &&
            stepParams.entityname === routeParams.entityname
          ) {
            return true;
          }
        }
        return false;
      });
    },
  },
};
</script>

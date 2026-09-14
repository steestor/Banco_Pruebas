# Features de origen IA

Simulan lo que el flujo de aprobación de la web promueve a `features_combined/{proyecto}/ai/`.
El pipeline las inyecta en el checkout bajo un subdirectorio `_ai_generated/`.

**Las dos se llaman `getSelector.feature` a propósito**, una por cada API. Es el caso que
destapa si la inyección aplana las rutas al nombre de fichero: aplanando, una pisa a la otra
y la pérdida no da ningún error. Deben llegar al checkout como
`_ai_generated/ArticuloApi_v1/getSelector.feature` y `_ai_generated/MovimientoApi_v1/getSelector.feature`.

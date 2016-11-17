
** This is a LSTM language model **


Usage:
```
CUDA_VISIBLE_DEVICES=$ID th train.lua --useGPU \
    --dropout 0.2 --batchSize 20 --validBatchSize 20 --save $model --model LSTMLM \
    --nlayers 1 \
    --lr $lr \
    --optimMethod SGD \
    --nhid 200 \
    --nin 100 \
    --minImprovement 1.001 \
    --train $train \
    --valid $valid \
    --test $test \
    | tee $log
```
Where $train, $valid, $test are the training, validation and testing split, respectively.

You can use the script here `experiments/test/run.sgd.sh`

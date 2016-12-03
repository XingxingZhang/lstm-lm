
** This is a LSTM language model **

## Training data format
a sentence per line and words are seperated by spaces.

## Train a language model on raw data (e.g. no UNK replacement)
1. Tokenize the dataset
2. Use `--freqCut N` to determine the vocabulary size of your model. The words appear `N` times or less in the training set will be replaced with `UNK`. During validation and testing, unknown words will also be mapped to `UNK`.
3. You can also use `--ingoreCase` to lowcase the dataset.
4. use `--seqLen N` to tell the model the longest sentence length will be less than `N`.
```
CUDA_VISIBLE_DEVICES=$ID th train.lua --useGPU \
    --dropout 0.2 --batchSize 20 --validBatchSize 20 --save $model --model LSTMLM \
    --freqCut 1 \
    --nlayers 1 \
    --seqLen 101 \
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
You can also take a look at `experiments/test/run.sgd.wiki.sh`

## Train a language model on data with UNK replacement (e.g. the commonly used ptb dataset)
1. disable `freqCut` by using `--freqCut 0`
2. use `--defaultUNK xxx` to indicate `xxx` represents the unknow words.

You can also take a look at `experiments/test/run.sgd.ptb.sh`


ID=`./gpu_lock.py --id-to-hog 2`
echo $ID
if [ $ID -eq -1 ]; then
    echo "this gpu is not free"
    exit
fi
./gpu_lock.py

curdir=`pwd`
codedir=/afs/inf.ed.ac.uk/group/project/img2txt/encdec/lstm-lm-v1.0
lr=1.0
label=.sgd
model=$curdir/model_$lr$label.t7
log=$curdir/log_$lr$label.txt

train=your_trianing_text_file
valid=your_validation_text_file
test=your_test_text_file


cd $codedir
CUDA_VISIBLE_DEVICES=$ID th train.lua --useGPU \
    --dropout 0.2 --batchSize 20 --validBatchSize 20 --save $model --model LSTMLM \
    --freqCut 1 \
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

cd $curdir

./gpu_lock.py --free $ID
./gpu_lock.py


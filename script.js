document.addEventListener('DOMContentLoaded', function() {
    const data = {
        "0": {
            "question": "Is input text-only?",
            "yes": "1",
            "no": "2"
        },
        "1": {
            "question": "Is output text-only?",
            "yes": "3",
            "no": "4"
        },
        "2": {
            "question": "Is output text-only?",
            "yes": "5",
            "no": "6"
        },
        "3": {
            "question": "Acceptance of commercialization LLMs?",
            "yes": "7",
            "no": "8"
        },
        "4": {
            "question": "Acceptance of commercialization LLMs?",
            "yes": "9",
            "no": "10"
        },
        "5": {
            "question": "Acceptance of commercialization LLMs?",
            "yes": "11",
            "no": "12"
        },
        "6": {
            "question": "Acceptance of commercialization LLMs?",
            "yes": "13",
            "no": "14"
        },
        "7": {
            "question": "Need to generate text for radiology reports?",
            "yes": "15",
            "no": "16"
        },
        "8": {
            "question": "Need to generate text for radiology reports?",
            "yes": "17",
            "no": "18"
        },
        "9": {
            "question": "Need to generate text for radiology reports?",
            "yes": "19",
            "no": "20"
        },
        "10": {
            "question": "Need to generate text for radiology reports?",
            "yes": "21",
            "no": "22"
        },
        "11": {
            "question": "Need to generate text for radiology reports?",
            "yes": "23",
            "no": "24"
        },
        "12": {
            "question": "Need to generate text for radiology reports?",
            "yes": "25",
            "no": "26"
        },
        "13": {
            "question": "Need to generate text for radiology reports?",
            "yes": "27",
            "no": "28"
        },
        "14": {
            "question": "Need to generate text for radiology reports?",
            "yes": "29",
            "no": "30"
        },
        "15": {
            "question": "Need to summarize radiology report?",
            "yes": "31",
            "no": "32"
        },
        "16": {
            "question": "Need to summarize radiology report?",
            "yes": "33",
            "no": "34"
        },
        "17": {
            "question": "Need to summarize radiology report?",
            "yes": "35",
            "no": "36"
        },
        "18": {
            "question": "Need to summarize radiology report?",
            "yes": "37",
            "no": "38"
        },
        "19": {
            "question": "Need to summarize radiology report?",
            "yes": "39",
            "no": "40"
        },
        "20": {
            "question": "Need to summarize radiology report?",
            "yes": "41",
            "no": "42"
        },
        "21": {
            "question": "Need to summarize radiology report?",
            "yes": "43",
            "no": "44"
        },
        "22": {
            "question": "Need to summarize radiology report?",
            "yes": "45",
            "no": "46"
        },
        "23": {
            "question": "Need to summarize radiology report?",
            "yes": "47",
            "no": "48"
        },
        "24": {
            "question": "Need to summarize radiology report?",
            "yes": "49",
            "no": "50"
        },
        "25": {
            "question": "Need to summarize radiology report?",
            "yes": "51",
            "no": "52"
        },
        "26": {
            "question": "Need to summarize radiology report?",
            "yes": "53",
            "no": "54"
        },
        "27": {
            "question": "Need to summarize radiology report?",
            "yes": "55",
            "no": "56"
        },
        "28": {
            "question": "Need to summarize radiology report?",
            "yes": "57",
            "no": "58"
        },
        "29": {
            "question": "Need to summarize radiology report?",
            "yes": "59",
            "no": "60"
        },
        "30": {
            "question": "Need to summarize radiology report?",
            "yes": "61",
            "no": "62"
        },
        "31": {
            "question": "Need to deploy models locally? 31",
            "yes": "63",
            "no": "64"
        },
        "32": {
            "question": "Need to deploy models locally? 32",
            "yes": "65",
            "no": "66"
        },
        "33": {
            "question": "Need to deploy models locally? 33",
            "yes": "67",
            "no": "68"
        },
        "34": {
            "answer": "Insufficient information to recommend LLMs. 34"
        },
        "35": {
            "question": "Need to deploy models locally? 35",
            "yes": "71",
            "no": "72"
        },
        "36": {
            "question": "Need to deploy models locally? 36",
            "yes": "73",
            "no": "74"
        },
        "37": {
            "question": "Need to deploy models locally? 37",
            "yes": "75",
            "no": "76"
        },
        "38": {
            "answer": "Insufficient information to recommend LLMs. 38"
        },
        "39": {
            "question": "Need to deploy models locally? 39",
            "yes": "79",
            "no": "80"
        },
        "40": {
            "question": "Need to deploy models locally? 40",
            "yes": "81",
            "no": "82"
        },
        "41": {
            "question": "Need to deploy models locally? 41",
            "yes": "83",
            "no": "84"
        },
        "42": {
            "answer": "Insufficient information to recommend LLMs. 42"
        },
        "43": {
            "question": "Need to deploy models locally? 43",
            "yes": "87",
            "no": "88"
        },
        "44": {
            "question": "Need to deploy models locally? 44",
            "yes": "89",
            "no": "90"
        },
        "45": {
            "question": "Need to deploy models locally? 45",
            "yes": "91",
            "no": "92"
        },
        "46": {
            "answer": "Insufficient information to recommend LLMs. 46"
        },
        "47": {
            "question": "Need to process medical images? 47",
            "yes": "95",
            "no": "96"
        },
        "48": {
            "question": "Need to process medical images? 48",
            "yes": "97",
            "no": "98"
        },
        "49": {
            "question": "Need to process medical images? 49",
            "yes": "99",
            "no": "100"
        },
        "50": {
            "question": "Need to process medical images? 50",
            "yes": "101",
            "no": "102"
        },
        "51": {
            "question": "Need to process medical images? 51",
            "yes": "103",
            "no": "104"
        },
        "52": {
            "question": "Need to process medical images? 52",
            "yes": "105",
            "no": "106"
        },
        "53": {
            "question": "Need to process medical images? 53",
            "yes": "107",
            "no": "108"
        },
        "54": {
            "question": "Need to process medical images? 54",
            "yes": "109",
            "no": "110"
        },
        "55": {
            "question": "Need to process medical images? 55",
            "yes": "111",
            "no": "112"
        },
        "56": {
            "question": "Need to process medical images? 56",
            "yes": "113",
            "no": "114"
        },
        "57": {
            "question": "Need to process medical images? 57",
            "yes": "115",
            "no": "116"
        },
        "58": {
            "question": "Need to process medical images? 58",
            "yes": "117",
            "no": "118"
        },
        "59": {
            "question": "Need to process medical images? 59",
            "yes": "119",
            "no": "120"
        },
        "60": {
            "question": "Need to process medical images? 60",
            "yes": "121",
            "no": "122"
        },
        "61": {
            "question": "Need to process medical images? 61",
            "yes": "123",
            "no": "124"
        },
        "62": {
            "question": "Need to process medical images? 62",
            "yes": "125",
            "no": "126"
        },
        "63": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog."
        },
        "64": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5, RaDialog. Here are the required resources: \n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog."
        },
        "65": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog."
        },
        "66": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), Google Bard (*), Bing Chat (*), IT5-220M (*), RaDialog-7B (*), accGPT (*), Glass AI (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nGoogle Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.\n\nThe input price is $0.0035/1k tokens and the output price is $0.0105/1k tokens.\n\nBing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\naccGPT: can be accessed via link https://github.com/maxrusse/accGPT.\n\nGlass AI: can be accessed via link https://glass.health."
        },
        "67": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA."
        },
        "68": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA."
        },
        "71": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 71"
        },
        "72": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 72"
        },
        "73": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 73"
        },
        "74": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 74"
        },
        "75": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 75"
        },
        "76": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 76"
        },
        "79": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 79"
        },
        "80": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5, RaDialog. Here are the required resources: \n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 80"
        },
        "81": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 81"
        },
        "82": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), Google Bard (*), Bing Chat (*), IT5-220M (*), RaDialog-7B (*), accGPT (*), Glass AI (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nGoogle Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.\n\nThe input price is $0.0035/1k tokens and the output price is $0.0105/1k tokens.\n\nBing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\naccGPT: can be accessed via link https://github.com/maxrusse/accGPT.\n\nGlass AI: can be accessed via link https://glass.health. 82"
        },
        "83": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 83"
        },
        "84": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 84"
        },
        "87": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 87"
        },
        "88": {
            "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: \n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 88"
        },
        "89": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 89"
        },
        "90": {
            "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: \n\nIT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 90"
        },
        "91": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 91"
        },
        "92": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA. 92"
        },
        "95": {
            "question": "Need to deploy models locally? 95",
            "yes": "191",
            "no": "192"
        },
        "96": {
            "question": "Need to deploy models locally? 96",
            "yes": "193",
            "no": "194"
        },
        "97": {
            "question": "Need to deploy models locally? 97",
            "yes": "195",
            "no": "196"
        },
        "98": {
            "question": "Need to deploy models locally? 98",
            "yes": "197",
            "no": "198"
        },
        "99": {
            "question": "Need to deploy models locally? 99",
            "yes": "199",
            "no": "200"
        },
        "100": {
            "question": "Need to deploy models locally? 100",
            "yes": "201",
            "no": "202"
        },
        "101": {
            "question": "Need to deploy models locally? 101",
            "yes": "203",
            "no": "204"
        },
        "102": {
            "answer": "Insufficient information to recommend LLMs 102"
        },
        "103": {
            "question": "Need to deploy models locally? 103",
            "yes": "207",
            "no": "208"
        },
        "104": {
            "question": "Need to deploy models locally? 104",
            "yes": "209",
            "no": "210"
        },
        "105": {
            "question": "Need to deploy models locally? 105",
            "yes": "211",
            "no": "212"
        },
        "106": {
            "question": "Need to deploy models locally? 106",
            "yes": "213",
            "no": "214"
        },
        "107": {
            "question": "Need to deploy models locally? 107",
            "yes": "215",
            "no": "216"
        },
        "108": {
            "question": "Need to deploy models locally? 108",
            "yes": "217",
            "no": "218"
        },
        "109": {
            "question": "Need to deploy models locally? 109",
            "yes": "219",
            "no": "220"
        },
        "110": {
            "answer": "Insufficient information to recommend LLMs 110"
        },
        "111": {
            "question": "Need to deploy models locally? 111",
            "yes": "223",
            "no": "224"
        },
        "112": {
            "question": "Need to deploy models locally? 112",
            "yes": "225",
            "no": "226"
        },
        "113": {
            "question": "Need to deploy models locally? 113",
            "yes": "227",
            "no": "228"
        },
        "114": {
            "question": "Need to deploy models locally? 114",
            "yes": "229",
            "no": "230"
        },
        "115": {
            "question": "Need to deploy models locally? 115",
            "yes": "231",
            "no": "232"
        },
        "116": {
            "question": "Need to deploy models locally? 116",
            "yes": "233",
            "no": "234"
        },
        "117": {
            "question": "Need to deploy models locally? 117",
            "yes": "235",
            "no": "236"
        },
        "118": {
            "answer": "Insufficient information to recommend LLMs 118"
        },
        "119": {
            "question": "Need to deploy models locally? 119",
            "yes": "239",
            "no": "240"
        },
        "120": {
            "question": "Need to deploy models locally? 120",
            "yes": "241",
            "no": "242"
        },
        "121": {
            "question": "Need to deploy models locally? 121",
            "yes": "243",
            "no": "244"
        },
        "122": {
            "question": "Need to deploy models locally? 122",
            "yes": "245",
            "no": "246"
        },
        "123": {
            "question": "Need to deploy models locally? 123",
            "yes": "247",
            "no": "248"
        },
        "124": {
            "question": "Need to deploy models locally? 124",
            "yes": "249",
            "no": "250"
        },
        "125": {
            "question": "Need to deploy models locally? 125",
            "yes": "251",
            "no": "252"
        },
        "126": {
            "answer": "Insufficient information to recommend LLMs 126"
        },
        "191": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n191"
        },
        "192": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 192"
        },
        "193": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 193"
        },
        "194": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), RaDialog-7B (*) , GPT-3.5, PaLM-E-84B. Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 194"
        },
        "195": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 195"
        },
        "196": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 196"
        },
        "197": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 197"
        },
        "198": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), GPT-4V (*), RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*), Google-Bard (*), Bing Chat (*), accGPT (*), Glass AI (*). Here are the required resources:\n \nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nGoogle Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.\n\nThe input price is $0.0035/1k tokens and the output price is $0.0105/1k tokens.\n\nBing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.\n\naccGPT: can be accessed via link https://github.com/maxrusse/accGPT.\n\nGlass AI: can be accessed via link https://glass.health. 198"
        },
        "199": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 199"
        },
        "200": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 200"
        },
        "201": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 201"
        },
        "202": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 202"
        },
        "203": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 203"
        },
        "204": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 204"
        },
        "207": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 207"
        },
        "208": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 208"
        },
        "209": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 209"
        },
        "210": {
            "answer": "The LLMs we recommend you use are:RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 210"
        },
        "211": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 211"
        },
        "212": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 212"
        },
        "213": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 213"
        },
        "214": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 214"
        },
        "215": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 215"
        },
        "216": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 216"
        },
        "217": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 217"
        },
        "218": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 218"
        },
        "219": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 219"
        },
        "220": {
            "answer": "The LLMs we recommend you use are: Gemini Ultra, PaLM-E-84B. Here are the required resources:\n\nGemini Ultra: available for individual users only at $19.99 per month.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 220"
        },
        "223": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 223"
        },
        "224": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 224"
        },
        "225": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 225"
        },
        "226": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), RaDialog-7B (*) , GPT-3.5, PaLM-E-84B. Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 226"
        },
        "227": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 227"
        },
        "228": {
            "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 228"
        },
        "229": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 229"
        },
        "230": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), GPT-4V (*), RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*), Google-Bard (*), Bing Chat (*), accGPT (*), Glass AI (*). Here are the required resources:\n \nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nGPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer.\n\nGoogle Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.\n\nThe input price is $0.0035/1k tokens and the output price is $0.0105/1k tokens.\n\nBing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.\n\naccGPT: can be accessed via link https://github.com/maxrusse/accGPT.\n\nGlass AI: can be accessed via link https://glass.health. 230"
        },
        "231": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 231"
        },
        "232": {
            "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 232"
        },
        "233": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 233"
        },
        "234": {
            "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nGPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 234"
        },
        "235": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 235"
        },
        "236": {
            "answer": "The LLMs we recommend you use are: Gemini Ultra, PaLM-E-84B, GPT-4V. Here are the required resources:\n\nGemini Ultra: available for individual users only at $19.99 per month.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens. 236"
        },
        "239": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 239"
        },
        "240": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 240"
        },
        "241": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 241"
        },
        "242": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 242"
        },
        "243": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 243"
        },
        "244": {
            "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 244"
        },
        "245": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 245"
        },
        "246": {
            "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:\n \nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog.\n\nRadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $82286.\n\nIt can be accessed via link https://github.com/chaoyi-wu/RadFM.\n\nCXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $7999.\n\nIt can be accessed via link https://github.com/ECOFRI/CXR_LLAVA.\n\nM3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $20571.\n\nIt can be accessed via link https://github.com/BAAI-DCAI/M3D.\n\nIT5-220M: can be accessed via link https://github.com/bmi-labmedinfo/radiology-qa-transformer. 246"
        },
        "247": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 247"
        },
        "248": {
            "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:\n\nGPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 248"
        },
        "249": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 249"
        },
        "250": {
            "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:\n\nPEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nIt can be accessed via link https://github.com/xtie97/PET-Report-Summarization.\n\nLLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $614.\n\nFlan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nClinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.\n\nFine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $1000.\n\nMe LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 48000W and the total price is $411429.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429.\n\nThey can be accessed via link https://github.com/BIDS-Xu-Lab/Me-LLaMA.\n\nRaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $1114.\n\nIt can be accessed via link https://github.com/ChantalMP/RaDialog. 250"
        },
        "251": {
            "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 251"
        },
        "252": {
            "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:\n\nPaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is more than 36000W and the total price is more than $308571.\n\nFine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 252"
        }
    }
    ;

    let currentNode = "0"; // Start node
    function displayQuestion(node) {
        const questionBox = document.getElementById('questionBox');
        questionBox.innerHTML = ""; // Clear previous content

        if (data[node] && data[node].question) {
            // Display the question
            const question = document.createElement('p');
            question.innerText = data[node].question;
            questionBox.appendChild(question);

            // Add Yes/No buttons
            const yesButton = document.createElement('button');
            yesButton.innerText = 'Yes';
            yesButton.onclick = function() {
                currentNode = data[node].yes;
                displayQuestion(currentNode);
            };
            questionBox.appendChild(yesButton);

            const noButton = document.createElement('button');
            noButton.innerText = 'No';
            noButton.onclick = function() {
                currentNode = data[node].no;
                displayQuestion(currentNode);
            };
            questionBox.appendChild(noButton);
        } else if (data[node] && data[node].answer) {
            // Display the final answer
            const answer = document.createElement('p');
            answer.innerText = data[node].answer;
            questionBox.appendChild(answer);
        } else {
            // Fallback if something goes wrong
            questionBox.innerText = "No more questions or answers.";
        }
    }

    // Start with the first question
    displayQuestion(currentNode);
});
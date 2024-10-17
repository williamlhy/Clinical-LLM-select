function loadContent(page) {
    if (page === 'home') {
        document.getElementById('content').innerHTML = `
            <h1>Welcome to My Website</h1>
            <p>This is the home page. Click the links on the left to navigate to other sections.</p>
        `;
    } else {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', page, true);
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    document.getElementById('content').innerHTML = xhr.responseText;
                    
                    // Check if the loaded page is the Q&A page
                    if (page === 's2.html') {
                        // Initialize Q&A logic after loading the HTML
                        const script = document.createElement('script');
                        script.innerHTML = `
                            document.addEventListener('DOMContentLoaded', function() {
            const data = {
                "0": {
                    "question": "Does your input include only textual data?",
                    "yes": "1",
                    "no": "2"
                },
                "1": {
                    "question": "Does your output include only textual data?",
                    "yes": "3",
                    "no": "4"
                },
                "2": {
                    "question": "Does your output include only textual data?",
                    "yes": "5",
                    "no": "6"
                },
                "3": {
                    "question": "Do you agree that your data may be shared with third parties, published, or made generally available?",
                    "yes": "7",
                    "no": "8"
                },
                "4": {
                    "question": "Do you agree that your data may be shared with third parties, published, or made generally available?",
                    "yes": "9",
                    "no": "10"
                },
                "5": {
                    "question": "Do you agree that your data may be shared with third parties, published, or made generally available?",
                    "yes": "11",
                    "no": "12"
                },
                "6": {
                    "question": "Do you agree that your data may be shared with third parties, published, or made generally available?",
                    "yes": "13",
                    "no": "14"
                },
                "7": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "15",
                    "no": "16"
                },
                "8": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "17",
                    "no": "18"
                },
                "9": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "19",
                    "no": "20"
                },
                "10": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "21",
                    "no": "22"
                },
                "11": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "23",
                    "no": "24"
                },
                "12": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "25",
                    "no": "26"
                },
                "13": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "27",
                    "no": "28"
                },
                "14": {
                    "question": "Do you need LLM to be able to generate text related to radiology reports?",
                    "yes": "29",
                    "no": "30"
                },
                "15": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "31",
                    "no": "32"
                },
                "16": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "33",
                    "no": "34"
                },
                "17": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "35",
                    "no": "36"
                },
                "18": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "37",
                    "no": "38"
                },
                "19": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "39",
                    "no": "40"
                },
                "20": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "41",
                    "no": "42"
                },
                "21": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "43",
                    "no": "44"
                },
                "22": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "45",
                    "no": "46"
                },
                "23": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "47",
                    "no": "48"
                },
                "24": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "49",
                    "no": "50"
                },
                "25": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "51",
                    "no": "52"
                },
                "26": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "53",
                    "no": "54"
                },
                "27": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "55",
                    "no": "56"
                },
                "28": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "57",
                    "no": "58"
                },
                "29": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "59",
                    "no": "60"
                },
                "30": {
                    "question": "Do you need LLM to be able to summarize text related to radiology reports?",
                    "yes": "61",
                    "no": "62"
                },
                "31": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 31",
                    "yes": "63",
                    "no": "64"
                },
                "32": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 32",
                    "yes": "65",
                    "no": "66"
                },
                "33": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 33",
                    "yes": "67",
                    "no": "68"
                },
                "34": {
                    "answer": "Sorry, there is not enough information to recommend LLM, please reselect the option. 34"
                },
                "35": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 35",
                    "yes": "71",
                    "no": "72"
                },
                "36": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 36",
                    "yes": "73",
                    "no": "74"
                },
                "37": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 37",
                    "yes": "75",
                    "no": "76"
                },
                "38": {
                    "answer": "Sorry, there is not enough information to recommend LLM, please reselect the option. 38"
                },
                "39": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 39",
                    "yes": "79",
                    "no": "80"
                },
                "40": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 40",
                    "yes": "81",
                    "no": "82"
                },
                "41": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 41",
                    "yes": "83",
                    "no": "84"
                },
                "42": {
                    "answer": "Sorry, there is not enough information to recommend LLM, please reselect the option. 42"
                },
                "43": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 43",
                    "yes": "87",
                    "no": "88"
                },
                "44": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 44",
                    "yes": "89",
                    "no": "90"
                },
                "45": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 45",
                    "yes": "91",
                    "no": "92"
                },
                "46": {
                    "answer": "Sorry, there is not enough information to recommend LLM, please reselect the option. 46"
                },
                "47": {
                    "question": "Do you need LLM to be able to process medical images? 47",
                    "yes": "95",
                    "no": "96"
                },
                "48": {
                    "question": "Do you need LLM to be able to process medical images? 48",
                    "yes": "97",
                    "no": "98"
                },
                "49": {
                    "question": "Do you need LLM to be able to process medical images? 49",
                    "yes": "99",
                    "no": "100"
                },
                "50": {
                    "question": "Do you need LLM to be able to process medical images? 50",
                    "yes": "101",
                    "no": "102"
                },
                "51": {
                    "question": "Do you need LLM to be able to process medical images? 51",
                    "yes": "103",
                    "no": "104"
                },
                "52": {
                    "question": "Do you need LLM to be able to process medical images? 52",
                    "yes": "105",
                    "no": "106"
                },
                "53": {
                    "question": "Do you need LLM to be able to process medical images? 53",
                    "yes": "107",
                    "no": "108"
                },
                "54": {
                    "question": "Do you need LLM to be able to process medical images? 54",
                    "yes": "109",
                    "no": "110"
                },
                "55": {
                    "question": "Do you need LLM to be able to process medical images? 55",
                    "yes": "111",
                    "no": "112"
                },
                "56": {
                    "question": "Do you need LLM to be able to process medical images? 56",
                    "yes": "113",
                    "no": "114"
                },
                "57": {
                    "question": "Do you need LLM to be able to process medical images? 57",
                    "yes": "115",
                    "no": "116"
                },
                "58": {
                    "question": "Do you need LLM to be able to process medical images? 58",
                    "yes": "117",
                    "no": "118"
                },
                "59": {
                    "question": "Do you need LLM to be able to process medical images? 59",
                    "yes": "119",
                    "no": "120"
                },
                "60": {
                    "question": "Do you need LLM to be able to process medical images? 60",
                    "yes": "121",
                    "no": "122"
                },
                "61": {
                    "question": "Do you need LLM to be able to process medical images? 61",
                    "yes": "123",
                    "no": "124"
                },
                "62": {
                    "question": "Do you need LLM to be able to process medical images? 62",
                    "yes": "125",
                    "no": "126"
                },
                "63": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>."
                },
                "64": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5, RaDialog-7B. Here are the required resources: <br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>."
                },
                "65": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>."
                },
                "66": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), Google Bard (*), Bing Chat (*), IT5-220M (*), RaDialog-7B (*), accGPT (*), Glass AI (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>Google Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.<br><br>The input price is $0.00125/1k tokens and the output price is $0.005/1k tokens.<br><br>Bing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>accGPT: can be accessed via link <a href='https://github.com/maxrusse/accGPT' target='_blank'>accGPT GitHub</a>.<br><br>Glass AI: can be accessed via link <a href='https://glass.health' target='_blank'>glassAI GitHub</a>."
                },
                "67": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>."
                },
                "68": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>."
                },
                "71": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 71"
                },
                "72": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 72"
                },
                "73": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 73"
                },
                "74": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 74"
                },
                "75": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 75"
                },
                "76": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 76"
                },
                "79": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 79"
                },
                "80": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5, RaDialog-7B. Here are the required resources: <br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 80"
                },
                "81": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 81"
                },
                "82": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), Google Bard (*), Bing Chat (*), IT5-220M (*), RaDialog-7B (*), accGPT (*), Glass AI (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>Google Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.<br><br>The input price is $0.00125/1k tokens and the output price is $0.005/1k tokens.<br><br>Bing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>accGPT: can be accessed via link <a href='https://github.com/maxrusse/accGPT' target='_blank'>accGPT GitHub</a>.<br><br>Glass AI: can be accessed via link <a href='https://glass.health' target='_blank'>glassAI GitHub</a>. 82"
                },
                "83": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 83"
                },
                "84": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 84"
                },
                "87": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 87"
                },
                "88": {
                    "answer": "The LLM we recommend you use is: RaDialog-7B. Here are the required resources: <br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 88"
                },
                "89": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 89"
                },
                "90": {
                    "answer": "The LLMs we recommend you use are: IT5-220M (*), RaDialog-7B (*). Here are the required resources: <br><br>IT5-220M: is a LLM fine-tuned from T5-220M, and can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 90"
                },
                "91": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 91"
                },
                "92": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>. 92"
                },
                "95": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 95",
                    "yes": "191",
                    "no": "192"
                },
                "96": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 96",
                    "yes": "193",
                    "no": "194"
                },
                "97": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 97",
                    "yes": "195",
                    "no": "196"
                },
                "98": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 98",
                    "yes": "197",
                    "no": "198"
                },
                "99": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 99",
                    "yes": "199",
                    "no": "200"
                },
                "100": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 100",
                    "yes": "201",
                    "no": "202"
                },
                "101": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 101",
                    "yes": "203",
                    "no": "204"
                },
                "102": {
                    "answer": "Insufficient information to recommend LLMs 102"
                },
                "103": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 103",
                    "yes": "207",
                    "no": "208"
                },
                "104": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 104",
                    "yes": "209",
                    "no": "210"
                },
                "105": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 105",
                    "yes": "211",
                    "no": "212"
                },
                "106": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 106",
                    "yes": "213",
                    "no": "214"
                },
                "107": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 107",
                    "yes": "215",
                    "no": "216"
                },
                "108": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 108",
                    "yes": "217",
                    "no": "218"
                },
                "109": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 109",
                    "yes": "219",
                    "no": "220"
                },
                "110": {
                    "answer": "Insufficient information to recommend LLMs 110"
                },
                "111": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 111",
                    "yes": "223",
                    "no": "224"
                },
                "112": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 112",
                    "yes": "225",
                    "no": "226"
                },
                "113": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 113",
                    "yes": "227",
                    "no": "228"
                },
                "114": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 114",
                    "yes": "229",
                    "no": "230"
                },
                "115": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 115",
                    "yes": "231",
                    "no": "232"
                },
                "116": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 116",
                    "yes": "233",
                    "no": "234"
                },
                "117": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 117",
                    "yes": "235",
                    "no": "236"
                },
                "118": {
                    "answer": "Insufficient information to recommend LLMs 118"
                },
                "119": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 119",
                    "yes": "239",
                    "no": "240"
                },
                "120": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 120",
                    "yes": "241",
                    "no": "242"
                },
                "121": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 121",
                    "yes": "243",
                    "no": "244"
                },
                "122": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 122",
                    "yes": "245",
                    "no": "246"
                },
                "123": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 123",
                    "yes": "247",
                    "no": "248"
                },
                "124": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 124",
                    "yes": "249",
                    "no": "250"
                },
                "125": {
                    "question": "Do you prefer to deploy LLM locally rather than in the cloud? 125",
                    "yes": "251",
                    "no": "252"
                },
                "126": {
                    "answer": "Insufficient information to recommend LLMs 126"
                },
                "191": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br>191"
                },
                "192": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 192"
                },
                "193": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 193"
                },
                "194": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), RaDialog-7B (*) , GPT-3.5, PaLM-E-84B. Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 194"
                },
                "195": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 195"
                },
                "196": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 196"
                },
                "197": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $576000.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $55992.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $144000.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 197"
                },
                "198": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), GPT-4V (*), RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*), Google-Bard (*), Bing Chat (*), accGPT (*), Glass AI (*). Here are the required resources:<br> <br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The price of renting 32 this type of GPU using cloud services is $200/1h.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The price of renting 8 this type of GPU using cloud services is $32.4/1h.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The price of renting 8 this type of GPU using cloud services is $50/1h.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>Google Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.<br><br>The input price is $0.00125/1k tokens and the output price is $0.005/1k tokens.<br><br>Bing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.<br><br>accGPT: can be accessed via link <a href='https://github.com/maxrusse/accGPT' target='_blank'>accGPT GitHub</a>.<br><br>Glass AI: can be accessed via link <a href='https://glass.health' target='_blank'>glassAI GitHub</a>. 198"
                },
                "199": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 199"
                },
                "200": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 200"
                },
                "201": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 201"
                },
                "202": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 202"
                },
                "203": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 203"
                },
                "204": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 204"
                },
                "207": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 207"
                },
                "208": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 208"
                },
                "209": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 209"
                },
                "210": {
                    "answer": "The LLMs we recommend you use are:RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 210"
                },
                "211": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 211"
                },
                "212": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 212"
                },
                "213": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $576000.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $55992.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $144000.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 213"
                },
                "214": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The price of renting 32 this type of GPU using cloud services is $200/1h.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The price of renting 8 this type of GPU using cloud services is $32.4/1h.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The price of renting 8 this type of GPU using cloud services is $50/1h.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 214"
                },
                "215": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 215"
                },
                "216": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 216"
                },
                "217": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 217"
                },
                "218": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $51429. 218"
                },
                "219": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 219"
                },
                "220": {
                    "answer": "The LLMs we recommend you use are: Gemini Ultra, PaLM-E-84B. Here are the required resources:<br><br>Gemini Ultra: available for individual users only at $19.99 per month.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 220"
                },
                "223": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 223"
                },
                "224": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 224"
                },
                "225": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 225"
                },
                "226": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), RaDialog-7B (*) , GPT-3.5, PaLM-E-84B. Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 226"
                },
                "227": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 227"
                },
                "228": {
                    "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 228"
                },
                "229": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $576000.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $55992.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $144000.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 229"
                },
                "230": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), GPT-3.5 (*), GPT-4V (*), RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*), Google-Bard (*), Bing Chat (*), accGPT (*), Glass AI (*). Here are the required resources:<br> <br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>GPT-3.5: the input price is $0.0005/1k tokens and the output price is $0.0015/1k tokens.<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The price of renting 32 this type of GPU using cloud services is $200/1h.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The price of renting 8 this type of GPU using cloud services is $32.4/1h.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The price of renting 8 this type of GPU using cloud services is $50/1h.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>.<br><br>Google Bard: has been renamed to Gemini, the original version is not accessible, you can access the latest Gemini 1.5 Pro.<br><br>The input price is $0.00125/1k tokens and the output price is $0.005/1k tokens.<br><br>Bing Chat: has been renamed to Copilot, the original version is not accessible, you can access the Copilot Advanced, averages $119 per month if paid annually.<br><br>accGPT: can be accessed via link <a href='https://github.com/maxrusse/accGPT' target='_blank'>accGPT GitHub</a>.<br><br>Glass AI: can be accessed via link <a href='https://glass.health' target='_blank'>glassAI GitHub</a>. 230"
                },
                "231": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 231"
                },
                "232": {
                    "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 232"
                },
                "233": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 233"
                },
                "234": {
                    "answer": "The LLMs we recommend you use are: GPT-4 (*), PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>GPT-4: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 234"
                },
                "235": {
                    "answer": "The LLM we recommend you use is: OphGLM-6.2B (*), PaLM-E-84B. Here are the required resources:<br><br>OphGLM-6.2B: no specific resource requirements for this model, refer to resources for LLMs of similar size (7B). Pre-train requires 8 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPUs is 2400W and the total price is $144000. Fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPUs is 2000W and the total price is $55992. Inference requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPUs is 250W and the total price is $6999. It can be accessed via link <a href='https://github.com/ML-AILab/OphGLM' target='_blank'>OphGLM GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 235"
                },
                "236": {
                    "answer": "The LLMs we recommend you use are: OphGLM-6.2B (*), Gemini Ultra, PaLM-E-84B, GPT-4V. Here are the required resources:<br><br>OphGLM-6.2B: no specific resource requirements for this model, refer to resources for LLMs of similar size (7B). Pre-train requires 8 NVIDIA TESLA A100-80GB GPUs. The price of renting 8 this type of GPU using cloud services is $50/1h. Fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The price of renting 8 this type of GPU using cloud services is $32.4/1h. Inference requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting 1 this type of GPU using cloud services is $4.05/1h. It can be accessed via link <a href='https://github.com/ML-AILab/OphGLM' target='_blank'>OphGLM GitHub</a>.<br><br>Gemini Ultra: available for individual users only at $19.99 per month.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h.<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens. 236"
                },
                "239": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 239"
                },
                "240": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 240"
                },
                "241": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 241"
                },
                "242": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), PaLM-E-84B. Here are the required resources:<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 242"
                },
                "243": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 243"
                },
                "244": {
                    "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 244"
                },
                "245": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The total thermal design power of the GPU is 9600W and the total price is $576000.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The total thermal design power of the GPU is 2000W and the total price is $55992.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The total thermal design power of the GPU is 2400W and the total price is $144000.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 245"
                },
                "246": {
                    "answer": "The LLMs we recommend you use are: RaDialog-7B (*), RadFM-14B (*), CXR-LLAVA-7B (*), M3D-LaMed (*), IT5-220M (*). Here are the required resources:<br> <br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>.<br><br>RadFM-14B: pre-train requires 32 NVIDIA TESLA A100-80GB GPUs. The price of renting 32 this type of GPU using cloud services is $200/1h.<br><br>It can be accessed via link <a href='https://github.com/chaoyi-wu/RadFM' target='_blank'>RadFM GitHub</a>.<br><br>CXR-LLAVA-7B: fine-tuning requires 8 NVIDIA TESLA A100-40GB GPUs. The price of renting 8 this type of GPU using cloud services is $32.4/1h.<br><br>It can be accessed via link <a href='https://github.com/ECOFRI/CXR_LLAVA' target='_blank'>CXRLLAVA GitHub</a>.<br><br>M3D-LaMed: pre-train requires 8 NVIDIA TESLA A100-80GB GPUS. The price of renting 8 this type of GPU using cloud services is $50/1h.<br><br>It can be accessed via link <a href='https://github.com/BAAI-DCAI/M3D' target='_blank'>M3DLaMed GitHub</a>.<br><br>IT5-220M: can be accessed via link <a href='https://github.com/bmi-labmedinfo/radiology-qa-transformer' target='_blank'>IT5 GitHub</a>. 246"
                },
                "247": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 247"
                },
                "248": {
                    "answer": "The LLMs we recommend you use are: GPT-4V, PaLM-E-84B. Here are the required resources:<br><br>GPT-4V: the input price is $0.01/1k tokens and the output price is $0.03/1k tokens.<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 248"
                },
                "249": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The total thermal design power of the GPU is 295W and the total price is $4300.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The total thermal design power of the GPU is 250W and the total price is $6999.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The total thermal design power of the GPU is 300W and the total price is $7799.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 249"
                },
                "250": {
                    "answer": "The LLMs we recommend you use are: PEGASUS-568M (*), LLaMA2-7B (*), Flan-T5-770M (*), Clinical-T5-770M (*), Me LLaMA-Chat-70B (*), Me LLaMA-70B (*), RaDialog-7B (*). Here are the required resources:<br><br>PEGASUS-568M: fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>It can be accessed via link <a href='https://github.com/xtie97/PET-Report-Summarization' target='_blank'>PEGASUS GitHub</a>.<br><br>LLaMA2-7B: fine-tuning requires 1 NVIDIA Quadro RTX 8000-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>Flan-T5-770M: fine-tuning requires 1 NVIDIA TESLA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Clinical-T5-770M: pre-train requires 1 TPU v3.8 cluster and the price is $1800.<br><br>Fine-tuning requires 1 NVIDIA A100-40GB GPU. The price of renting this type of GPU using cloud services is $4.05/1h.<br><br>Me LLaMA-Chat-70B and Me LLaMA-70B: pre-train requires 160 NVIDIA TESLA A100-80GB GPUs. The price of renting 160 GPUs of this type using cloud services is $1760/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 GPUs of this type using cloud services is $88/1h.<br><br>They can be accessed via link <a href='https://github.com/BIDS-Xu-Lab/Me-LLaMA' target='_blank'>MeLLaMA GitHub</a>.<br><br>RaDialog-7B: fine-tuning requires 1 NVIDIA A40-48GB GPU. The price of renting a GPU with 48GB of memory using a cloud service is $3.75/1h.<br><br>It can be accessed via link <a href='https://github.com/ChantalMP/RaDialog' target='_blank'>RaDialog GitHub</a>. 250"
                },
                "251": {
                    "answer": "The LLM we recommend you use is: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Fine-tuning requires 8 H100 GPUs. The total thermal design power of the GPU is 2400W and the total price is $360000. 251"
                },
                "252": {
                    "answer": "The LLMs we recommend you use are: PaLM-E-84B. Here are the required resources:<br><br>PaLM-E-84B: no specific resource requirements for this model, refer to resources for LLMs of similar size (70B). Pre-train requires more than 120 NVIDIA TESLA A100-80GB GPUs. The price of renting 120 this type of GPU using cloud services is $750/1h.<br><br>Fine-tuning requires 8 H100 GPUs. The price of renting 8 this type of GPU using cloud services is $88/1h. 252"
                }
            };

            let currentNode = "0"; // Starting node
            let questionHistory = []; // Keeps track of answered questions

            // Function to display a question based on the node
            function displayQuestion(node, questionIndex) {
                const questionContainer = document.getElementById('questionContainer');
                // Clear questions beyond this index
                questionContainer.innerHTML = '';

                // Display history
                questionHistory.slice(0, questionIndex).forEach(q => appendQuestion(q.node, q.choice, q.number));

                // Display the current question
                appendQuestion(node, null, questionIndex + 1);
            }

            function appendQuestion(node, selectedChoice, questionNumber) {
                const questionContainer = document.getElementById('questionContainer');

                if (data[node] && data[node].question) {
                    const questionDiv = document.createElement('div');
                    questionDiv.classList.add('question');

                    // Display fixed question number
                    const questionNumberElem = document.createElement('p');
                    questionNumberElem.classList.add('questionNumber');
                    questionNumberElem.innerText = \`Question \${questionNumber}:\`;
                    questionDiv.appendChild(questionNumberElem);

                    // Display question text
                    const questionText = document.createElement('p');
                    questionText.innerText = data[node].question;
                    questionDiv.appendChild(questionText);

                    // Create Yes button
                    const yesButton = document.createElement('button');
                    yesButton.innerText = 'Yes';
                    yesButton.classList.toggle('selected', selectedChoice === 'yes');
                    yesButton.onclick = function () {
                        updateHistory(node, 'yes', questionNumber);
                        currentNode = data[node].yes;
                        displayQuestion(currentNode, questionNumber);
                    };
                    questionDiv.appendChild(yesButton);

                    // Create No button
                    const noButton = document.createElement('button');
                    noButton.innerText = 'No';
                    noButton.classList.toggle('selected', selectedChoice === 'no');
                    noButton.onclick = function () {
                        updateHistory(node, 'no', questionNumber);
                        currentNode = data[node].no;
                        displayQuestion(currentNode, questionNumber);
                    };
                    questionDiv.appendChild(noButton);

                    // Append the question block to the container
                    questionContainer.appendChild(questionDiv);

                } else if (data[node] && data[node].answer) {
                    // Create a div for the final answer
                    const answerDiv = document.createElement('div');
                    answerDiv.classList.add('answer');

                    const answerText = document.createElement('p');
                    answerText.innerHTML = data[node].answer;  // Allow HTML content for line breaks and links
                    answerDiv.appendChild(answerText);

                    // Append the answer to the container
                    questionContainer.appendChild(answerDiv);
                } else {
                    // Handle if no more questions or no data found
                    const noMoreQuestions = document.createElement('p');
                    noMoreQuestions.innerText = "No more questions or answers.";
                    questionContainer.appendChild(noMoreQuestions);
                }
            }

            function updateHistory(node, choice, questionNumber) {
                // Check if we are revisiting a question and modify history accordingly
                const historyIndex = questionHistory.findIndex(q => q.number === questionNumber);
                if (historyIndex !== -1) {
                    questionHistory = questionHistory.slice(0, historyIndex); // Remove subsequent questions
                }

                // Add current question to history
                questionHistory.push({ node, choice, number: questionNumber });
            }

            // Start the first question
            displayQuestion(currentNode, 0);
        });
                        `;
                        document.body.appendChild(script);
                    }
                } else {
                    document.getElementById('content').innerHTML = '<p>Error loading content.</p>';
                }
            }
        };
        
        xhr.onerror = function() {
            document.getElementById('content').innerHTML = '<p>Error loading content.</p>';
        };

        xhr.send();
    }
}

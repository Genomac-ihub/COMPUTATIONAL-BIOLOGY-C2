import time
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

def download_gdc_file(file_id, file_name):
    url = f"https://api.gdc.cancer.gov/data/{file_id}"
    
    
    # Configure retry strategy
    session = requests.Session()
    retries = Retry(
        total=5,
        backoff_factor=1,
        status_forcelist=[500, 502, 503, 504]
    )
    session.mount('https://', HTTPAdapter(max_retries=retries))
    
    try:
        response = session.get(
            url,
            headers={"Content-Type": "application/json"},
            timeout=30
        )
        
        if response.status_code == 200:
            with open(file_name, "wb") as f:
                f.write(response.content)
            print(f"✅ Downloaded: {file_name}")
        else:
            print(f"❌ Failed to download file: {file_id} | Status: {response.status_code}")
    except Exception as e:
        print(f"❌ Error downloading {file_name}: {str(e)}")

def get_file_ids(case_id, data_category, data_type=None):
    filters = [
        {
            "op": "in",
            "content": {
                "field": "cases.submitter_id",
                "value": [case_id]
            }
        },
        {
            "op": "in",
            "content": {
                "field": "data_category",
                "value": [data_category]
            }
        }
    ]

    if data_type:
        filters.append({
            "op": "in",
            "content": {
                "field": "data_type",
                "value": [data_type]
            }
        })

    query = {
        "filters": {
            "op": "and",
            "content": filters
        },
        "format": "JSON",
        "fields": "file_id,file_name",
        "size": "100"
    }

    response = requests.post("https://api.gdc.cancer.gov/files", json=query)
    if response.status_code == 200:
        return response.json()["data"]["hits"]
    else:
        print(f"❌ Error querying files: {response.status_code}")
        return []

def download_tcga_data(case_id):
    print(f"\n🔍 Fetching clinical and RNA-Seq data for patient: {case_id}")

    clinical_files = get_file_ids(case_id, data_category="Clinical")
    rna_files = get_file_ids(
        case_id,
        data_category="Transcriptome Profiling",
        data_type="Gene Expression Quantification"
    )

    if not clinical_files:
        print("⚠️ No clinical files found.")
    else:
        for i, file in enumerate(clinical_files, 1):
            print(f"📄 Clinical ({i}/{len(clinical_files)}): {file['file_name']}")
            download_gdc_file(file["file_id"], file["file_name"])
            if i < len(clinical_files):  # Add delay between requests
                time.sleep(5)

    if not rna_files:
        print("⚠️ No RNA-Seq files found.")
    else:
        for i, file in enumerate(rna_files, 1):
            print(f"🧬 RNA-Seq ({i}/{len(rna_files)}): {file['file_name']}")
            download_gdc_file(file["file_id"], file["file_name"])
            if i < len(rna_files):  # Add delay between requests
                time.sleep(5)
# Example usage:
download_tcga_data("TCGA-AN-A03Y")


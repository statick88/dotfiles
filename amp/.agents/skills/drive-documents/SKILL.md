---
name: drive-documents
description: >
  Process Google Drive directories or local folders containing office documents (PDF, DOCX, PPTX, XLSX, TXT, IMG, etc.). Extract context, metadata, and content from documents to feed project context. Use this skill when user provides a Drive directory path and wants to analyze documents for project context.
license: Apache-2.0
metadata:
  author: opencode
  version: "1.0"
keywords: drive, documents, pdf, docx, pptx, xlsx, txt, image, context, analysis
---

## Drive Document Processing Skill

### Overview
This skill enables processing of Google Drive directories or local folders containing mixed office documents. It extracts context, metadata, and content to feed project context for AI assistants.

### When to Use
- User provides a Google Drive directory path
- User provides a local folder with mixed document types
- User wants to analyze documents for project context
- User needs to extract information from multiple document formats
- User wants to generate project summaries from document collections

### Directory Processing Workflow

#### 1. Directory Discovery
```python
import os
from pathlib import Path

def discover_documents(directory_path: str) -> dict:
    """
    Discover all supported documents in directory.
    
    Supported formats:
    - PDF: .pdf
    - Word: .docx, .doc
    - Excel: .xlsx, .xls, .csv, .tsv
    - PowerPoint: .pptx, .ppt
    - Text: .txt, .md, .json, .xml, .yaml, .yml
    - Images: .png, .jpg, .jpeg, .gif, .bmp, .svg, .tiff
    """
    extensions = {
        'pdf': ['.pdf'],
        'word': ['.docx', '.doc'],
        'excel': ['.xlsx', '.xls', '.csv', '.tsv'],
        'powerpoint': ['.pptx', '.ppt'],
        'text': ['.txt', '.md', '.json', '.xml', '.yaml', '.yml'],
        'image': ['.png', '.jpg', '.jpeg', '.gif', '.bmp', '.svg', '.tiff']
    }
    
    discovered = {k: [] for k in extensions}
    
    for root, dirs, files in os.walk(directory_path):
        for file in files:
            ext = Path(file).suffix.lower()
            for doc_type, exts in extensions.items():
                if ext in exts:
                    full_path = os.path.join(root, file)
                    discovered[doc_type].append({
                        'path': full_path,
                        'name': file,
                        'extension': ext,
                        'size': os.path.getsize(full_path),
                        'modified': os.path.getmtime(full_path)
                    })
    
    return discovered
```

#### 2. Metadata Extraction
```python
import os
from datetime import datetime

def extract_metadata(documents: dict) -> list:
    """Extract metadata from discovered documents."""
    metadata = []
    
    for doc_type, docs in documents.items():
        for doc in docs:
            info = {
                'type': doc_type,
                'name': doc['name'],
                'path': doc['path'],
                'size_kb': round(doc['size'] / 1024, 2),
                'modified': datetime.fromtimestamp(doc['modified']).isoformat(),
                'extension': doc['extension']
            }
            metadata.append(info)
    
    return sorted(metadata, key=lambda x: x['modified'], reverse=True)
```

### Document Processing by Type

#### PDF Documents
Use the **pdf** skill for PDF-specific operations:
```python
from pypdf import PdfReader

def extract_pdf_content(pdf_path: str) -> dict:
    reader = PdfReader(pdf_path)
    return {
        'pages': len(reader.pages),
        'text': extract_all_text(reader),
        'metadata': reader.metadata
    }

def extract_all_text(reader: PdfReader) -> str:
    text = ""
    for page in reader.pages:
        text += page.extract_text() or ""
    return text
```

#### Word Documents (DOCX)
Use the **docx** skill for Word document operations:
```python
import zipfile
import xml.etree.ElementTree as ET

def extract_docx_content(docx_path: str) -> dict:
    """Extract text and basic structure from DOCX."""
    with zipfile.ZipFile(docx_path, 'r') as zip_ref:
        xml_content = zip_ref.read('word/document.xml')
        root = ET.fromstring(xml_content)
    
    text = extract_text_from_xml(root)
    
    return {
        'text': text,
        'word_count': len(text.split()),
        'has_images': 'word/media' in zip_ref.namelist()
    }

def extract_text_from_xml(element: ET.Element) -> str:
    text = []
    if element.text:
        text.append(element.text)
    for child in element:
        text.extend(extract_text_from_xml(child))
        if child.tail:
            text.append(child.tail)
    return ''.join(text)
```

#### Excel Documents (XLSX/CSV)
Use the **xlsx** skill for spreadsheet operations:
```python
import pandas as pd

def extract_excel_content(excel_path: str) -> dict:
    """Extract sheets and data from Excel files."""
    result = {'sheets': [], 'data': {}}
    
    if excel_path.endswith('.csv'):
        df = pd.read_csv(excel_path)
        result['sheets'] = ['Sheet1']
        result['data']['Sheet1'] = {
            'rows': len(df),
            'columns': list(df.columns),
            'preview': df.head(5).to_dict('records')
        }
    else:
        with pd.ExcelFile(excel_path) as xlsx:
            result['sheets'] = xlsx.sheet_names
            for sheet in xlsx.sheet_names:
                df = pd.read_excel(xlsx, sheet_name=sheet)
                result['data'][sheet] = {
                    'rows': len(df),
                    'columns': list(df.columns),
                    'preview': df.head(5).to_dict('records')
                }
    
    return result
```

#### PowerPoint Documents (PPTX)
Use the **pptx** skill for PowerPoint operations:
```python
from pptx import Presentation

def extract_pptx_content(pptx_path: str) -> dict:
    """Extract slides and text from PowerPoint."""
    prs = Presentation(pptx_path)
    
    slides = []
    for i, slide in enumerate(prs.slides):
        slide_text = {
            'slide_number': i + 1,
            'shapes': []
        }
        
        for shape in slide.shapes:
            if hasattr(shape, 'text') and shape.text.strip():
                slide_text['shapes'].append({
                    'type': shape.shape_type.name,
                    'text': shape.text[:500]  # Limit text length
                })
        
        slides.append(slide_text)
    
    return {
        'total_slides': len(prs.slides),
        'slides': slides
    }
```

#### Text Files
```python
def extract_text_content(file_path: str) -> dict:
    """Extract content from text-based files."""
    encodings = ['utf-8', 'latin-1', 'cp1252', 'utf-16']
    
    content = None
    encoding_used = None
    
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as f:
                content = f.read()
            encoding_used = encoding
            break
        except (UnicodeDecodeError, UnicodeError):
            continue
    
    if content is None:
        with open(file_path, 'rb') as f:
            content = f.read()
            encoding_used = 'binary'
    
    return {
        'content': content[:10000] if len(content) > 10000 else content,
        'full_length': len(content),
        'encoding': encoding_used,
        'lines': content.count('\n') + 1 if isinstance(content, str) else 0
    }
```

#### Image Files
```python
from PIL import Image
import os

def extract_image_metadata(image_path: str) -> dict:
    """Extract metadata from image files."""
    try:
        with Image.open(image_path) as img:
            return {
                'format': img.format,
                'mode': img.mode,
                'size': img.size,
                'width': img.width,
                'height': img.height,
                'has_alpha': img.mode in ('RGBA', 'LA'),
                'file_size_kb': round(os.path.getsize(image_path) / 1024, 2)
            }
    except Exception as e:
        return {'error': str(e)}
```

### Context Generation for Projects

#### Generate Project Context Summary
```python
def generate_project_context(documents: dict, processing_results: dict) -> dict:
    """Generate a comprehensive project context from processed documents."""
    
    context = {
        'summary': {
            'total_documents': sum(len(docs) for docs in documents.values()),
            'documents_by_type': {k: len(v) for k, v in documents.items()},
            'processing_status': {}
        },
        'documents': [],
        'key_findings': [],
        'action_items': [],
        'metadata': {
            'generated_at': datetime.now().isoformat(),
            'processing_tool': 'drive-documents-skill'
        }
    }
    
    for doc_type, docs in documents.items():
        processed = processing_results.get(doc_type, [])
        context['summary']['processing_status'][doc_type] = {
            'total': len(docs),
            'processed': len(processed)
        }
        
        for doc, result in zip(docs, processed):
            context['documents'].append({
                'type': doc_type,
                'name': doc['name'],
                'path': doc['path'],
                'content_summary': summarize_content(result),
                'metadata': doc
            })
    
    return context

def summarize_content(result: dict) -> str:
    """Create a brief summary of processed content."""
    summaries = []
    
    if 'pages' in result:
        summaries.append(f"{result['pages']} pages")
    if 'text' in result:
        text_len = len(result.get('text', ''))
        summaries.append(f"{text_len} chars of text")
    if 'slides' in result:
        summaries.append(f"{result.get('total_slides', len(result['slides']))} slides")
    if 'sheets' in result:
        summaries.append(f"{len(result['sheets'])} sheets")
    if 'word_count' in result:
        summaries.append(f"{result['word_count']} words")
    
    return '; '.join(summaries) if summaries else 'Processed'
```

#### Extract Action Items and Key Information
```python
import re

def extract_action_items(text: str) -> list:
    """Extract potential action items from text."""
    patterns = [
        r'(?:action|todo|to-do|task):\s*(.+?)(?:\n|$)',
        r'(?:deadline|due|date):\s*(.+?)(?:\n|$)',
        r'(?:priority|important|critical):\s*(.+?)(?:\n|$)',
        r'[-•*]\s*(?:TODO|FIX|ACTION|BUG|NEED TO):\s*(.+?)(?:\n|$)',
    ]
    
    action_items = []
    for pattern in patterns:
        matches = re.findall(pattern, text, re.IGNORECASE)
        action_items.extend(matches)
    
    return list(set(action_items))  # Remove duplicates
```

### Usage Examples

#### Example 1: Process Drive Directory
```
User: "Process my Drive folder /Users/statick/Drive/Project-X and extract context"

Assistant Workflow:
1. Call discover_documents("/Users/statick/Drive/Project-X")
2. Process each document type using appropriate extractors
3. Generate project context with generate_project_context()
4. Return structured context summary
```

#### Example 2: Extract Specific Document Information
```
User: "Find all PDF files in the current directory and extract their text"

Assistant Workflow:
1. discover_documents() → filter for 'pdf' type
2. For each PDF, use extract_pdf_content()
3. Return combined text content
```

#### Example 3: Generate Project Summary
```
User: "Create a summary of all documents in the project folder"

Assistant Workflow:
1. discover_documents() to find all files
2. extract_metadata() to get file info
3. generate_project_context() to create summary
4. Present: document counts, recent files, types distribution
```

### Processing Order
1. **Text files** (.txt, .md, .json, .xml) - Fast, minimal processing
2. **Office documents** (.docx, .xlsx, .pptx) - Moderate processing
3. **PDFs** - Variable processing time, may need OCR
4. **Images** - Fast metadata, slow for OCR

### Error Handling
```python
def safe_process_document(file_path: str, doc_type: str) -> dict:
    """Safely process a document with error handling."""
    try:
        processors = {
            'pdf': extract_pdf_content,
            'word': extract_docx_content,
            'excel': extract_excel_content,
            'powerpoint': extract_pptx_content,
            'text': extract_text_content,
            'image': extract_image_metadata
        }
        
        if doc_type in processors:
            return processors[doc_type](file_path)
        else:
            return {'error': f'No processor for type: {doc_type}'}
    
    except Exception as e:
        return {
            'error': str(e),
            'file': file_path,
            'type': doc_type
        }
```

### Integration with Other Skills
- Use **pdf** skill for advanced PDF operations (forms, OCR, encryption)
- Use **docx** skill for Word document creation/editing
- Use **xlsx** skill for complex spreadsheet operations
- Use **pptx** skill for PowerPoint presentation modifications

### Output Format
The skill returns structured JSON with:
```json
{
  "summary": {
    "total_documents": 15,
    "documents_by_type": {
      "pdf": 5,
      "word": 3,
      "excel": 4,
      "text": 2,
      "image": 1
    }
  },
  "documents": [
    {
      "type": "pdf",
      "name": "requirements.pdf",
      "path": "/path/to/requirements.pdf",
      "content_summary": "12 pages; 4500 chars of text",
      "metadata": {...}
    }
  ],
  "action_items": ["Review requirements by Friday", "Schedule team meeting"],
  "metadata": {
    "generated_at": "2024-01-15T10:30:00",
    "processing_tool": "drive-documents-skill"
  }
}
```

### Keywords
drive, google drive, directory, folder, documents, office, pdf, docx, pptx, xlsx, txt, image, png, jpg, context, analysis, project, extract, metadata, processing

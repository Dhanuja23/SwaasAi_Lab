FROM python:3.10

RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"
WORKDIR /app

# Install dependencies
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your code and models
COPY --chown=user . .

# Hugging Face uses port 7860
EXPOSE 7860

# Start Flask using Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:7860", "app:app"]

from flask import Flask, request, jsonify
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from flask_ngrok import run_with_ngrok

app = Flask(__name__)

# Load your dataset
excel_file_path = 'dataset1.xlsx'
exercise_data = pd.read_excel(excel_file_path)

# Initialize TF-IDF Vectorizer
tfidf_vectorizer = TfidfVectorizer(stop_words='english')

# Preprocess data and fit the vectorizer
exercise_data['Benefits'].fillna("", inplace=True)
exercise_data['Instructions'].fillna("", inplace=True)
tfidf_vectorizer.fit(exercise_data['Benefits'] + ' ' + exercise_data['Instructions'])

def get_recommendations(user_query):
    # Transform user input
    user_vector = tfidf_vectorizer.transform([user_query])

    # Compute cosine similarities
    tfidf_matrix = tfidf_vectorizer.transform(exercise_data['Benefits'] + ' ' + exercise_data['Instructions'])
    cosine_scores = cosine_similarity(user_vector, tfidf_matrix)

    # Get indices of recommended exercises
    exercise_indices = cosine_scores.argsort()[0][::-1][:5]  # Top 5 recommendations

    # Retrieve recommended exercises
    recommended_exercises = exercise_data.iloc[exercise_indices]
    return recommended_exercises.to_dict('records')

@app.route('/api', methods=['GET'])
def recommend():
    user_input = request.args.get('query')
    if user_input:
        recommendations = get_recommendations(user_input)

        return jsonify(recommendations)
    else:
        return jsonify({'error': 'Missing query parameter'}), 400


if __name__ == '__main__':
    app.run()

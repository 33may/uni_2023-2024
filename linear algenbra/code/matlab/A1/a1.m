% Ratings Matrix
R = [2, -1, 2, -2, 2, 1; 
     1, -1, 2, 0, 2, 2; 
     1, NaN, 1, -2, 1, -1; 
     1, -2, 1, -1, 1, 2; 
     -1, NaN, 0, -2, -1, -2; 
     0, NaN, 0, -1, -1, 0; 
     -2, 2, -1, 1, 0, 1; 
     -2, NaN, -2, -1, -2, -2];

% Imputation of missing values for Anton using mean imputation
anton_missing_idx = isnan(R(:, 2));
R(anton_missing_idx, 2) = mean(R(~anton_missing_idx, 2), 'omitnan');

% Target user (Anton) index
target_user = 2;

% Target movie indices (movies that Anton hasn't rated yet)
target_movies = find(isnan(R(:, target_user)));

% Number of most similar users to consider
N = 2;

% Prediction for each target movie
predictions = zeros(length(target_movies), 1);

for idx = 1:length(target_movies)
    target_movie = target_movies(idx);

    % Define the target vector (excluding the target movie)
    t = R(:, target_user);
    t(target_movie) = [];

    % Define the modified ratings matrix (excluding the target movie row)
    R_prime = R;
    R_prime(target_movie, :) = [];

    % Calculate cosine similarities
    s = zeros(1, size(R_prime, 2));
    for j = 1:size(R_prime, 2)
        if j ~= target_user
            u = R_prime(:, j);
            % Calculate cosine similarity only for common non-NaN elements
            common_idx = ~isnan(t) & ~isnan(u);
            if sum(common_idx) > 0
                t_common = t(common_idx);
                u_common = u(common_idx);
                s(j) = dot(t_common, u_common) / (norm(t_common) * norm(u_common));
            else
                s(j) = -999; % If no common elements, set to a low value
            end
        else
            s(j) = -999; % Exclude target user from similarity
        end
    end

    % Apply softmax to similarity scores
    s_exp = exp(s - max(s)); % Subtract max(s) for numerical stability
    s = s_exp ./ sum(s_exp);

    % Find the indices of the N most similar users
    [~, sorted_idx] = sort(s, 'descend');
    similar_users = sorted_idx(1:N);

    % Calculate weighted average for prediction
    numerator = 0;
    denominator = 0;
    for k = 1:N
        user_idx = similar_users(k);
        weight = s(user_idx);
        rating = R(target_movie, user_idx);
        if ~isnan(rating)
            numerator = numerator + weight * rating;
            denominator = denominator + weight;
        end
    end

    % Predicted rating for the target movie
    predictions(idx) = numerator / denominator;
end

% Display predicted ratings for Anton
for i = 1:length(target_movies)
    fprintf('Predicted rating for Anton for movie %d: %.2f\n', target_movies(i), predictions(i));
end

﻿:- dynamic score/1.

% Knowledgebase
question(q1, 'what is the capital of France?', ['paris']).
question(q2, 'What is the biggest mountain in the world?', ['everest']).
question(q3, 'What is the largest country in the world?', ['russia']).
question(q4, 'What is the capital of Australia?', ['canberra']).
question(q5, 'Who painted the Mona Lisa?', ['leonardo da vinci']).
question(q6, 'Which planet is known as the Red Planet?', ['mars']).
question(q7, 'What is the currency of Japan?', ['japanese yen']).
question(q8, 'Who wrote the play "Romeo and Juliet"?', ['william shakespeare']).
question(q9, 'What is the chemical symbol for gold?', ['au']).
question(q10, 'In which city is the famous Taj Mahal located?', ['agra']).

% Answer Check
check_answer(Question, Answer) :-
    question(Question, _, CorrectAnswers),
    member(Answer, CorrectAnswers).

% Part of the quiz
play_quiz:-
    write('Welcome to the Quiz Game!'), nl,
    reset_score,
    randomize_questions(Questions),
    play_questions(Questions),
    score(Score),
    write('Game over! Your score is: '), write(Score), nl,
    score_message(Score).

%Reset score to run quiz again
reset_score :-
    retractall(score(_)),
    assert(score(0)).

%Shows previous quiz score
show_previous_score :-
    score(Score),
    write('Previous quiz Score: '), write(Score), nl.

play_questions([]).
play_questions([Q | Qs]) :-
    play_question(Q),
    play_questions(Qs).

play_question(Question) :-
    question(Question, QuestionText, _),
    write(QuestionText), nl,
    read_line_to_codes(user_input, AnswerCodes),
    string_codes(AnswerString, AnswerCodes),
    atom_string(Answer, AnswerString),
    check_answer(Question, Answer),
    write('Correct answer!'), nl,
    increment_score(1).
play_question(_) :-
    write('Wrong answer!'), nl.

score(0).
increment_score(Increment) :-
    retract(score(S)),
    NewScore is S + Increment,
    assert(score(NewScore)).

%Randomizing questions for each run of the quiz
randomize_questions(Questions) :-
    findall(Q, question(Q, _, _), AllQuestions),
    random_permutation(AllQuestions, Questions).

%Message of performance in quiz
score_message(Score) :-
    Score =:= 0,
    write('You can Atleast try!'), nl.
score_message(Score) :-
    Score < 5, Score \= 0,
    write('Hard luck this time and better luck next time!'), nl.
score_message(Score) :-
    Score >= 5, Score < 8,
    write('You scored pretty average. Keep it up!'), nl.
score_message(Score) :-
    Score >= 8, Score < 10,
    write('Good job! You scored well.'), nl.
score_message(Score) :-
    Score =:= 10,
    write('Excellent! You scored a perfect 10.'), nl.

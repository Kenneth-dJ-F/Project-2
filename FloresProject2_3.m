clc
clear

% Game: Dice Battle
% Rules
fprintf('Welcome to Dice Battle!\n')
fprintf('You and the computer each roll a 6-sided die.\n')
fprintf('Higher roll wins the round.\n')
fprintf('First to reach 3 wins takes the game!\n\n')

% Scores
playerScore = 0;
compScore = 0;

% Game loop
while playerScore < 3 && compScore < 3
    % Roll dice
    playerRoll = randi(6);
    compRoll = randi(6);
    % Display rolls
    fprintf('You rolled a %d. Computer rolled a %d.\n', playerRoll, compRoll)
    % Decide round
    if playerRoll > compRoll
        fprintf('You win this round!\n\n')
        playerScore = playerScore + 1;
    elseif compRoll > playerRoll
        fprintf('Computer wins this round!\n\n')
        compScore = compScore + 1;
    else
        fprintf('It''s a tie! No points.\n\n')
    end
    % Show current score
    fprintf('Score: You %d  |  Computer %d\n\n', playerScore, compScore)
end

% Final result
if playerScore > compScore
    fprintf('Congratulations! You won the game!\n')
else
    fprintf('Computer wins the game. Better luck next time!\n')
end

% Ask to play again
playAgain = input('\nDo you want to play again? (y/n): ', 's');
if playAgain == 'y' || playAgain == 'Y'
    run(mfilename)   % restarts script
else
    fprintf('Thanks for playing!\n')
end


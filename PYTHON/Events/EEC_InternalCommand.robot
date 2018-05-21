*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 155 10 228 163 201 2 186 131 225 156 146 116 0 226 45 92 16 106 253 32 248 49 163 174 225 51 0 255 146 110 191 27 24 146 145 124 72 12 248 188 210 105 218 147 111 218 224 50 197 35 81 52 80 9 68 142 17 169 125 18 5 82 92 116 200 8 89 235 42 125 68 148 161 48 237 62 182 227 235 5 28 239 137 10 37 179 135 160 179 103 21 3 86 107 12 17 145 1 29 244 81 62 243 239 237 123 113 45 160 80 12 119 29 29 48 114 181 214 221 100 111 138 104 42 255 212 249 225 93 157 249 164 118 100 120 134 147 126 81 39 56 76 44 17 4 128 133 66 236 87 133 83 247 76 63 123 86 245 62 85 121 224 21 228 85 162 106 44 54 165 135 49 23 232 158 154 42 98 159 123 114 203 37 131 189 151 110 216 32 135 219 104 37 201 135 221 212 16 10 21 36 172 147 35 141 62 145 82 88 82 217 137 36 247 241 14 90 246 246 193 19 212 84 219 177 40 211 42 248 139 189 102 79 80 55 196 23 31 37 123 3 206 27 145 45 14 109 45 134 220 127 31 155 235 9 53 132 88 237 217 39 161 76 68 184 163 103 80 166 20 223 129 136 77 218 160 178 97 212 9 130 149 197 191 45 198 231 236 170 32 90 169 12 62 81 150 200 131 11 42 68 67 51 68 4 254 224 233 199 181 21 25 78 228 118 91 1 126 229 163 6 70 244 56 75 83 124 34 16 59 196 100 34 9 65 65 21 191 217 183 150 158 51 87 72 0 211 13 203 181 67 13 214 219 155 186 253 171 162 53 190 24 227 171 111 135 239 160 161 158 229 241 149 177 104 243 22 135 115 175 216 109 7 236 102 240 23 166 197 158 26 220 230 18 40 40 8 53 89 96 139 205 53 168 174 22 88 241 107 242 148 152 51 25 48 65 192 135 48 48 22 12 159 5 189 163 240 21 22 38 109 183 137 82 116 194 133 246 56 235 111 76 241 121 11 171 124 4 217 86 51 167 105 62 56 241 130 67 244 137 234 67 102 144 58 134 109 67 16 97 65 194 172 178 54 234 28 16 62 186 63 171 172 141 13 98 171 109 162 180 22 34 142 129 243 29 35 64 25 213 217 154 221 133 99 54 235 221 78 52 141 162 214 40 245 28 74 125 116 206 158 96 20 204 255 57 243 152 200 64 43 16 239 131 39 191 196 94 95 100 94 222 42 77 170 63 133 78 245 222 167 242 13 69 128 135 162 73 37 29 81 99 112 145 70 154 104 173 128 162 32 84 66 255 182 210 100 31 202 225 22 99 167 230 150 53 90 54 154 206 57 196 178 114 71 89 162 163 139 104 126 84 187 56 233 78 184 165 223 75 99 43 128 168 45 222 0 233 167 173 35 81 233 161 74 171 74 237 158 64 205 237 7 197 160 210 122 118 105 109 254 11 233 106 251 59 66 195 46 127 82 243 22 51 213 81 72 6 165 102 155 14 252 109 111 53 110 217 124 71 6 90 10 49 94 192 172 218 0 107 23 47 189 190 233 244 70 181 51 225 22 210 74 228 33 19 226 21 33 196 100 205 204 235 16 138 135 58 163 154 133 101 224 240 3 74 255 181 69 217 173 182 237 203 254 107 19 37 8 87 95 152 249 159 109 200 23 52 77 72 245 67 144 183 43 126 53 251 204 137 176 0 2 12 14 234 66 222 135 184 76 36 244 173 68 238 36 172 132 104 137 82 101 237 32 192 175 22 156 112 217 80 76 201 192 231 211 61 240 2 250 8 192 12 78 163 106 158 4 24 223 96 152 151 137 147 213 141 197 104 23 51 17 94 91 191 78 6 191 6 15 116 92 216 234 55 69 207 240 186 186 195 214 112 222 202 9 73 9 159 139 246 67 255 59 226 9 223 237 107 174 24 159 1 83 27 195 233 236 41 222 152 101 136 114 32 224 127 97 105 76 128 222 23 146 77 49 137 128 94 147 215 25 54 113 20 28 122 255 138 100 154 161 216 54 3 196 43 43 33 21 3 209 243 218 38 63 58 71 14 183 86 44 63 64 50 111 53 251 212 186 16 122 56 249 0 231 53 170 85 207 14 156 184 88 210 124 98 138 82 168 201 48 172 214 200 34 213 62 67 223 16 120 224 197 129 57 126 38 116 159 135 166 181 29 252 43 199 86 167 177 168 39 238 220 44 42 3 187 22 32 43 183 212 80 207 198 206 67 139 86 46 187 210 61 235 109 164 34 204 -1561128852
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1

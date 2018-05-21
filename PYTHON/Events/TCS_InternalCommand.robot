*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 195 187 149 201 182 143 58 201 7 85 82 212 21 86 190 185 237 126 210 39 69 26 205 118 63 254 248 189 120 85 220 43 28 198 154 211 119 234 70 102 71 181 152 38 59 6 110 73 91 189 31 239 236 124 142 78 131 122 236 116 135 120 43 112 101 38 129 171 82 222 241 54 238 58 233 146 88 44 41 78 55 251 204 10 253 224 174 123 126 240 93 65 215 169 96 223 212 67 3 69 88 71 68 174 112 72 62 26 19 181 153 11 134 133 90 111 89 90 10 167 17 118 140 71 241 208 125 113 146 138 157 172 253 60 123 106 247 225 5 209 91 33 78 14 149 42 36 194 99 227 210 111 160 0 128 152 168 238 21 18 71 20 8 128 35 21 67 178 108 90 248 115 131 55 15 77 106 167 35 210 112 250 242 44 55 134 104 202 3 120 88 49 19 5 240 213 108 167 132 13 228 184 215 140 199 92 132 99 152 177 138 166 82 108 159 98 218 211 169 241 165 200 49 245 87 163 8 31 138 53 190 195 50 80 205 202 217 118 227 53 35 100 84 134 37 222 15 143 146 52 5 17 26 93 52 57 22 118 155 150 226 172 158 176 23 221 237 218 138 223 148 242 21 105 134 23 178 8 131 39 158 255 5 226 172 30 180 6 24 177 13 213 188 245 140 61 96 91 105 238 206 133 245 66 234 141 124 25 20 247 141 127 212 14 133 136 97 178 183 37 238 130 95 49 121 152 185 107 22 99 178 253 211 215 183 164 193 95 8 221 198 203 38 97 83 193 235 198 128 251 200 112 122 79 90 129 212 216 219 137 248 25 145 177 66 25 40 97 90 149 112 115 162 0 13 125 33 223 178 35 73 210 56 190 62 13 247 223 38 171 218 152 38 215 172 187 106 73 26 55 179 180 168 46 50 115 241 199 203 60 83 207 113 129 232 80 42 107 16 3 19 30 3 29 250 16 81 96 249 182 129 159 147 145 198 14 208 229 239 205 159 97 142 149 224 178 167 25 45 199 33 159 142 68 63 105 38 234 116 121 134 244 49 216 147 117 121 177 17 51 20 248 153 155 182 114 10 250 254 89 70 201 52 110 135 20 223 248 125 83 34 252 176 75 206 179 43 250 198 21 150 157 136 213 122 1 156 41 126 128 10 23 167 225 206 114 1 252 5 178 205 62 198 223 209 185 69 22 166 191 59 122 20 74 46 23 102 120 237 231 205 108 54 204 145 145 57 200 220 135 72 48 59 98 157 186 222 17 150 1 83 103 117 197 115 207 50 103 230 65 181 112 211 81 227 4 247 148 124 159 77 212 99 252 161 238 135 229 110 144 130 254 89 117 145 195 117 111 246 158 97 252 151 218 195 135 123 172 187 31 247 252 93 214 87 32 119 242 188 255 65 148 164 216 3 213 171 77 208 237 149 126 227 97 150 137 202 225 118 75 94 48 217 65 148 41 137 31 11 77 149 213 202 49 139 18 203 154 98 167 34 156 216 245 125 79 55 166 126 191 127 114 37 172 216 112 155 128 75 77 79 225 141 112 127 221 106 167 247 156 211 164 172 29 82 191 212 212 145 187 246 90 7 167 181 174 201 115 78 47 223 7 222 212 3 108 64 249 172 94 99 121 1 0 176 241 202 88 187 220 18 148 238 187 19 215 119 98 77 225 155 29 229 224 96 201 254 124 156 80 184 48 48 72 46 0 156 45 74 252 134 68 130 93 118 1 19 7 35 3 118 0 53 254 9 116 5 205 37 107 18 176 10 37 133 75 226 80 239 193 227 241 91 31 177 210 213 240 217 231 159 131 76 137 215 125 26 233 92 4 94 191 172 246 111 139 223 87 100 51 83 241 6 60 64 215 210 26 224 172 128 113 162 220 133 187 155 165 154 120 91 38 231 58 145 189 238 88 135 232 204 99 6 175 94 175 56 158 205 142 103 35 82 103 6 35 105 241 218 98 49 193 26 122 156 116 86 79 227 55 197 213 158 181 66 162 56 102 86 197 241 188 251 98 115 115 108 221 250 13 154 42 225 33 72 124 159 134 223 6 129 87 62 57 248 203 130 9 32 164 18 230 212 115 44 84 124 191 134 147 66 23 192 88 101 21 223 54 188 182 204 79 66 61 99 22 10 54 120 9 46 99 46 58 67 6 35 211 230 143 155 255 220 130 167 225 142 247 78 123 220 169 255 101 90 154 154 154 112 31 221 212 192 184 41 87 6 36 161 95 175 112 146 13 127 168 154 43 32 16 242099826
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
